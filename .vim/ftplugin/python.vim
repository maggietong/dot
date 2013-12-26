
""" :setlocal

verbose map <buffer> <F8> :w<CR>:!/usr/bin/env pyflakes % <CR>  " fix me fix me tsting
verbose map <buffer> <F9> :w<CR>:!/usr/bin/env pep8 % <CR>
verbose map <buffer> <S-e> :w<CR>:!/usr/bin/env python -u % <CR>
verbose map <buffer> <S-t> :w<CR>:!/usr/bin/env python -m pudb.run % <CR><CR>
verbose nmap <buffer> <F9> :PymodeLintAuto <CR>

function! b:PyCleanWhiteSpace()
    call g:CleanWhiteSpace()
    :%s/\s\+$//e
    retab
endfunction

verbose map <buffer><silent> <F8> :call b:PyCleanWhiteSpace()<CR>
autocmd BufWritePre *.py call b:PyCleanWhiteSpace()
