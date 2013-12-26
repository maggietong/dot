""" :setlocal

verbose map <buffer> <S-e> :w<CR>:!/usr/bin/env sh % <CR>

function! b:ShCleanWhiteSpace()
    call g:CleanWhiteSpace()
    :%s/\s\+$//e
    retab
endfunction

verbose map <buffer><silent> <F8> :call b:ShCleanWhiteSpace()<CR>
autocmd BufWritePre *.sh call b:ShCleanWhiteSpace()
