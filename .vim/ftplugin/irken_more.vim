source ~/.vim/ftplugin/scheme.vim

nnoremap <buffer> <Leader>rb :w<CR>:!irken_compilerun.sh %:p <CR>
