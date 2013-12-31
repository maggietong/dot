""" :setlocal

nnoremap <silent> <buffer> ,rl :PymodeLint<CR>
"nnoremap <silent> <buffer> ,rb :PymodeRun<CR>
nnoremap <buffer> ,rb :w<CR>:!/usr/bin/env python %:p <CR><CR>
nnoremap <buffer> ,rd :w<CR>:!/usr/bin/env python -m pudb.run %:p <CR><CR>
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
