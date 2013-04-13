
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> <S-t> :w<CR>:!/usr/bin/env python -m pudb.run % <CR><CR>
map <buffer> <F8> :w<CR>:!pyflakes % <CR>
map <buffer> <F9> :w<CR>:!pep8 % <CR>

autocmd BufWritePre * :%s/\s\+$//e
