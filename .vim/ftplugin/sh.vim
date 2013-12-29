""" :setlocal

verbose map <buffer> ,rb :w<CR>:!/usr/bin/env sh % <CR>
autocmd BufWritePre *.sh call g:CleanWhiteSpace()
