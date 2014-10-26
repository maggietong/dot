""" :setlocal

nnoremap <silent> <buffer> <Leader>rl :PymodeLint<CR>
"nnoremap <silent> <buffer> <Leader>rb :PymodeRun<CR>
"nnoremap <buffer> <Leader>rb :w<CR>:!/usr/bin/env python %:p <CR>
nnoremap <buffer> <Leader>rb :w<CR>:!python %:p <CR>
nnoremap <buffer> <Leader>rd :w<CR>:!python -m pudb.run %:p <CR><CR>
nnoremap <silent> <buffer> q :lclose \| pclose <CR>

autocmd BufWritePre *.py call g:CleanWhiteSpace()

function! VirtualEnvoStatus()
    if ! g:virtualenv_loaded
        return ''
    endif
    return 'PYVE:'. virtualenv#statusline()
endfunction

let s:py_active_left = [ 've_status', 'py_loc' ]
let s:py_component_function = {
\ 'py_loc': 'TagInStatusLine',
\ 've_status': 'VirtualEnvoStatus',
\}

call extend(g:lightline.component_function, s:py_component_function)
call add(g:lightline.active.left, s:py_active_left)
