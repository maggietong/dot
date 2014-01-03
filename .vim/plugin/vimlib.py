import sys
import os
import vim
import vim_git
import collections

class MenuEntry(object):
    pass

menu = collections.OrderedDict()

def append_menu_entry(key, menu_entry):
    menu[key] = menu_entry

def output_to_window(output):
    if not isinstance(output, basestring):
        output = '\n'.join(output)
    output = output.replace('"', '\\"')
    menu_mappings = ''
    for key, value in menu.items():
        menu_mappings += 'map <buffer> {key} {vim_cmd}\n'.format(key=key, vim_cmd=value.vim_cmd)
    vim.command("""
    let g:VimLibBufferName = "__vimlib__"
    function! g:SetTempBufferAttributes()
        "nnoremap <silent> <buffer> q :wincmd c<CR>
        nnoremap <silent> <buffer> q :q!<CR>
        {}
        setlocal nobuflisted
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        setlocal nonumber
    endfunction
    """.format(menu_mappings))

    vim.command("""
    function! g:OpenVimLibBuffer(string)
        let scr_bufnum = bufnr(g:VimLibBufferName)
        let old_x = @x
        let @x = a:string
        setlocal noreadonly
        setlocal modifiable
        if scr_bufnum == -1
            exe "new " . g:VimLibBufferName
            call g:SetTempBufferAttributes()
        else
            let scr_winnum = bufwinnr(scr_bufnum)
            if scr_winnum != -1
                if winnr() != scr_winnum
                    exe scr_winnum . "wincmd w"
                    call g:SetTempBufferAttributes()
                endif
            else
                exe "split +buffer" . scr_bufnum
                call g:SetTempBufferAttributes()
            endif
        endif
        silent 1,$delete _
        silent! put x
        setlocal nomodifiable
        setlocal readonly
        let @x = old_x
    endfunction
    "exec "autocmd BufEnter ". g:VimLibBufferName ." g:SetTempBufferAttributes()"
    """)

    vim.command("""call g:OpenVimLibBuffer("{output}")""".format(output=output))

def get_cmd_output(cmd):
    if not isinstance(cmd, basestring):
        cmd, = cmd
    cmd = cmd.replace('"', r'\"')
    vim.command("""
    redir => out
    silent execute "{}"
    redir END
    """.format(cmd))
    out = vim.eval('out')
    return out

menu_entry = MenuEntry()
menu_entry.desc = 'mappings'
menu_entry.vim_cmd = ":python vimlib.output_to_window(vimlib.get_cmd_output('map <Leader>'))<CR>"
append_menu_entry('m', menu_entry=menu_entry)

menu_entry = MenuEntry()
menu_entry.desc = 'menu'
menu_entry.vim_cmd = ":python vimlib.output_to_window(vimlib.get_menu())<CR>"
append_menu_entry('?', menu_entry=menu_entry)

menu_entry = MenuEntry()
menu_entry.desc = 'pyenv'
menu_entry.vim_cmd = ":python vimlib.output_to_window(vimlib.get_python_environment_info())<CR>"
append_menu_entry('e', menu_entry=menu_entry)

menu_entry = MenuEntry()
menu_entry.desc = 'gitstat'
menu_entry.vim_cmd = """:python vimlib.output_to_window(vim_git.get_status(vim.eval("expand('%:p')")))<CR>"""
append_menu_entry('g', menu_entry=menu_entry)

def get_python_environment_info():
    output = []
    output.append('Python Executable: {}'.format(sys.executable))
    output.append('-'*20)
    output.append('sys.path:')
    for path in sys.path:
        output.append('  {}'.format(path))
    output.append('-'*20)
    output.append('Version Info: {}'.format(sys.version_info))
    #output.append(sys.subversion)
    output.append('-'*20)
    output.append('Loaded Modules:')
    for module in sorted(set(sys.modules.keys())):
        output.append('  {}'.format(module))
    output.append('-'*20)
    output.append('Globals:')
    for var in sorted(set(globals())):
        output.append('  {}'.format(var))
    return output

def get_menu():
    global menu
    output = []
    for key, entry in menu.items():
        output.append('{}) {}'.format(key, entry.desc))
    return output

output_to_window(get_menu())

