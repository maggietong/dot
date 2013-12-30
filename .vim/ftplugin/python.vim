""" :setlocal

nnoremap <silent> <buffer> ,rl :PymodeLint<CR>
nnoremap <silent> <buffer> ,rb :PymodeRun<CR>
"nnoremap <buffer> ,rd :w<CR>:!/usr/bin/env new_debug_window python -m pudb.run %:p <CR><CR>
nnoremap <buffer> ,rd :w<CR>:!/usr/bin/env python -m pudb.run %:p <CR><CR>
nnoremap <silent> <buffer> q :lclose \| pclose <CR>

autocmd BufWritePre *.py call g:CleanWhiteSpace()

function! VirtualEnvoStatus()
    if ! g:virtualenv_loaded
        return ''
    endif
    return 'PYVE:'. virtualenv#statusline()
endfunction

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'py_loc' ], [ 've_status' ] ]
    \ },
    \ 'component_function': {
    \   'py_loc': 'TagInStatusLine',
    \   've_status': 'VirtualEnvoStatus',
    \ }
    \ }
