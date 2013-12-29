""" :setlocal

nnoremap <silent> <buffer> ,rl :PymodeLint<CR>
nnoremap <silent> <buffer> ,rb :PymodeRun<CR>
"nnoremap <buffer> ,rd :w<CR>:!/usr/bin/env new_debug_window python -m pudb.run %:p <CR><CR>
nnoremap <buffer> ,rd :w<CR>:!/usr/bin/env python -m pudb.run %:p <CR><CR>
nnoremap <silent> <buffer> q :lclose \| pclose <CR>

autocmd BufWritePre *.py call g:CleanWhiteSpace()

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'py_loc' ] ]
    \ },
    \ 'component_function': {
    \   'py_loc': 'TagInStatusLine',
    \ }
    \ }
