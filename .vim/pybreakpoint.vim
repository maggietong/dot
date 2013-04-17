###  Stolen from: https://dev.launchpad.net/UltimateVimPythonSetup

def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))
    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)
    vim.current.buffer.append(
       "%(space)spudb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)
    for strLine in vim.current.buffer:
        if strLine == "import pudb":
            break
    else:
        vim.current.buffer.append( 'import pudb', 0)
        vim.command( 'normal j1')

def RemoveBreakpoints():
    import re
    nCurrentLine = int( vim.eval( 'line(".")'))
    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pudb" or strLine.lstrip()[:15] == "pudb.set_trace()":
            nLines.append( nLine)
        nLine += 1
    nLines.reverse()
    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1
    vim.command( "normal %dG" % nCurrentLine)

vim.command( 'map <f7> :py SetBreakpoint()<cr>')
vim.command( "map <s-f7> :py RemoveBreakpoints()<cr>")

" map <silent> <F2> :\
" if &number <Bar>
"     \set nonumber <Bar>
" \else <Bar>
"     \set number <Bar>
" \endif<cr>
