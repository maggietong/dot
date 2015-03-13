
Plugin 'vivien/vim-addon-linux-coding-style'

setlocal expandtab
setlocal showcmd
setlocal nowrap
setlocal textwidth=120
setlocal shiftwidth=8

autocmd BufWritePre *.c silent g:CleanWhiteSpace()<CR>
autocmd BufWritePre *.h silent g:CleanWhiteSpace()<CR>
autocmd BufWritePre *.cpp silent g:CleanWhiteSpace()<CR>

function! g:RunThisCFile()
    if filereadable(expand("%:p:h") . "/Makefile")
        :!make
    else
        :!gcc -o %:p.vim_run %:p
        :!%:p.vim_run
    endif
endfun

nnoremap <buffer> <Leader>rb :call g:RunThisCFile() <CR>
