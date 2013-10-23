
map <buffer> <S-e> :w<CR>:!/auto/ucs-platform-qa/ixos/bin/ixwish % <CR>
autocmd BufWritePre * :%s/\s\+$//e
