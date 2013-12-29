" This was stolen/modified from https://github.com/vim-scripts/pythonhelper
"
" Credit goes to Michal Vitecek <fuf-at-mageo-dot-cz>, according to the source.
"

python << EOS

import re
import sys
import time
import traceback
import vim
TAGS = {}
TAGLINENUMBERS = {}
BUFFERTICKS = {}

class PythonTag(object):
    TT_CLASS = 0
    TT_METHOD = 1
    TT_FUNCTION = 2
    TAG_TYPE_NAME = {
        TT_CLASS: "class",
        TT_METHOD: "method",
        TT_FUNCTION: "function",
    }

    def __init__(self, type, name, fullName, lineNumber, indentLevel):
        self.type = type
        self.name = name
        self.fullName = fullName
        self.lineNumber = lineNumber
        self.indentLevel = indentLevel

    def __str__(self):
        return "[%s (%s) [%s, %u, %u]" % (self.name, PythonTag.TAG_TYPE_NAME[self.type],
                                          self.fullName, self.lineNumber, self.indentLevel,)
    __repr__ = __str__


class SimplePythonTagsParser(object):
    TABSIZE = 8
    COMMENTS_INDENT_RE = re.compile('([ \t]*)([^\n#]*).*')
    CLASS_RE = re.compile('class[ \t]+([^(:]+).*')
    METHOD_RE = re.compile('def[ \t]+([^(]+).*')

    def __init__(self, source):
        if ((hasattr(source, 'readline') == 0) or
                (callable(source.readline) == 0)):
            raise AttributeError("Source must have callable readline method.")
        self.source = source

    def getTags(self):
        tagLineNumbers = []
        tags = {}
        tagsStack = []
        lineNumber = 0
        while 1:
            line = self.source.readline()
            if (line == ''):
                break
            lineNumber += 1
            lineMatch = self.COMMENTS_INDENT_RE.match(line)
            lineContent = lineMatch.group(2)
            tagMatch = self.CLASS_RE.match(lineContent)
            if (tagMatch):
                currentTag = self.getPythonTag(tagsStack, lineNumber, lineMatch.group(1),
                                               tagMatch.group(1), self.tagClassTypeDecidingMethod)
                tagLineNumbers.append(lineNumber)
                tags[lineNumber] = currentTag
            else:
                tagMatch = self.METHOD_RE.match(lineContent)
                if (tagMatch):
                    currentTag = self.getPythonTag(tagsStack, lineNumber, lineMatch.group(1),
                                                   tagMatch.group(1), self.tagFunctionTypeDecidingMethod)
                    tagLineNumbers.append(lineNumber)
                    tags[lineNumber] = currentTag
        return (tagLineNumbers, tags,)

    def getParentTag(self, tagsStack):
        if (len(tagsStack)):
            parentTag = tagsStack[-1]
        else:
            parentTag = None
        return parentTag

    def computeIndentationLevel(indentChars):
        indentLevel = 0
        for char in indentChars:
            if (char == '\t'):
                indentLevel += SimplePythonTagsParser.TABSIZE
            else:
                indentLevel += 1
        return indentLevel
    computeIndentationLevel = staticmethod(computeIndentationLevel)

    def getPythonTag(self, tagsStack, lineNumber, indentChars, tagName, tagTypeDecidingMethod):
        indentLevel = self.computeIndentationLevel(indentChars)
        parentTag = self.getParentTag(tagsStack)
        while (parentTag):
            if (parentTag.indentLevel >= indentLevel):
                del tagsStack[-1]
            else:
                tag = PythonTag(tagTypeDecidingMethod(parentTag.type), tagName, "%s.%s" % (parentTag.fullName, tagName,), lineNumber, indentLevel)
                break
            parentTag = self.getParentTag(tagsStack)
        else:
            tag = PythonTag(tagTypeDecidingMethod(None), tagName, tagName, lineNumber, indentLevel)
        tagsStack.append(tag)
        return tag

    def tagClassTypeDecidingMethod(self, parentTagType):
        return PythonTag.TT_CLASS

    def tagFunctionTypeDecidingMethod(self, parentTagType):
        if (parentTagType == PythonTag.TT_CLASS):
            return PythonTag.TT_METHOD
        else:
            return PythonTag.TT_FUNCTION


class VimReadlineBuffer(object):
    def __init__(self, vimBuffer):
        self.vimBuffer = vimBuffer
        self.currentLine = -1
        self.bufferLines = len(vimBuffer)

    def readline(self):
        self.currentLine += 1
        if (self.currentLine == self.bufferLines):
            return ''
        return "%s\n" % (self.vimBuffer[self.currentLine],)


def getNearestLineIndex(row, tagLineNumbers):
    nearestLineNumber = -1
    nearestLineIndex = -1
    for lineIndex, lineNumber in enumerate(tagLineNumbers):
        if (nearestLineNumber < lineNumber <= row):
            nearestLineNumber = lineNumber
            nearestLineIndex = lineIndex
        if (lineNumber >= row):
            break
    return nearestLineIndex


def getTags(bufferNumber, changedTick):
    global TAGLINENUMBERS, TAGS, BUFFERTICKS
    if (BUFFERTICKS.get(bufferNumber, None) == changedTick):
        return (TAGLINENUMBERS[bufferNumber], TAGS[bufferNumber],)
    simpleTagsParser = SimplePythonTagsParser(VimReadlineBuffer(vim.current.buffer))
    tagLineNumbers, tags = simpleTagsParser.getTags()
    TAGS[bufferNumber] = tags
    TAGLINENUMBERS[bufferNumber] = tagLineNumbers
    BUFFERTICKS[bufferNumber] = changedTick
    return (tagLineNumbers, tags,)


def findTag(bufferNumber, changedTick):
    try:
        tagLineNumbers, tags = getTags(bufferNumber, changedTick)
        currentBuffer = vim.current.buffer
        currentWindow = vim.current.window
        row, col = currentWindow.cursor
        nearestLineIndex = getNearestLineIndex(row, tagLineNumbers)
        while (nearestLineIndex > -1):
            nearestLineNumber = tagLineNumbers[nearestLineIndex]
            for lineNumber in xrange(nearestLineNumber + 1, row):
                line = currentBuffer[lineNumber]
                if (len(line)):
                    lineStart = 0
                    i = 0
                    while ((i < len(line)) and (line[i].isspace())):
                        if (line[i] == '\t'):
                            lineStart += SimplePythonTagsParser.TABSIZE
                        else:
                            lineStart += 1
                        i += 1
                    if (i == len(line)):
                        continue
                    if (line[i] == '#'):
                        continue
                    if (lineStart <= tags[nearestLineNumber].indentLevel):
                        nearestLineIndex -= 1
                        break
            else:
                break
        else:
            nearestLineNumber = -1
        tagDescription = ""
        if (nearestLineNumber > -1):
            tagInfo = tags[nearestLineNumber]
            tagDescription = tagInfo.fullName
        ##################
        vim.command("let w:PHStatusLine=\"%s\"" % (tagDescription,))
    except Exception:
        ec, ei, tb = sys.exc_info()
        while (tb != None):
            if (tb.tb_next == None):
                break
            tb = tb.tb_next
        print "ERROR: %s %s %s:%u" % (ec.__name__, ei, tb.tb_frame.f_code.co_filename, tb.tb_lineno,)
        time.sleep(0.5)


def deleteTags(bufferNumber):
    global TAGS, TAGLINENUMBERS, BUFFERTICKS
    try:
        del TAGS[bufferNumber]
        del TAGLINENUMBERS[bufferNumber]
        del BUFFERTICKS[bufferNumber]
    except:
        pass


EOS


function! PHCursorHold()
    if (!exists('b:current_syntax') || (b:current_syntax != 'pymode'))
    let w:PHStatusLine = ''
    return
    endif

    execute 'python findTag(' . expand("<abuf>") . ', ' . b:changedtick . ')'
endfunction


function! PHBufferDelete()
    let w:PHStatusLine = ""

    execute 'python deleteTags(' . expand("<abuf>") . ')'
endfunction


function! TagInStatusLine()
    if (exists("w:PHStatusLine"))
        return w:PHStatusLine
    else
        return ""
    endif
endfunction


function! PHPreviousClassMethod()
    call search('^[ \t]*\(class\|def\)\>', 'bw')
endfunction


function! PHNextClassMethod()
    call search('^[ \t]*\(class\|def\)\>', 'w')
endfunction


function! PHPreviousClass()
    call search('^[ \t]*class\>', 'bw')
endfunction


function! PHNextClass()
    call search('^[ \t]*class\>', 'w')
endfunction


function! PHPreviousMethod()
    call search('^[ \t]*def\>', 'bw')
endfunction


function! PHNextMethod()
    call search('^[ \t]*def\>', 'w')
endfunction

set updatetime=500

autocmd CursorHold * call PHCursorHold()
autocmd CursorHoldI * call PHCursorHold()
autocmd BufDelete * silent call PHBufferDelete()
