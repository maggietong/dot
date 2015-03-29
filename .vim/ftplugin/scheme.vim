source ~/.vim/util.vim

unlet g:AutoPairsLoaded
au Filetype scheme let b:AutoPairs = {"(": ")", "[": "]"}

source ~/.vim/bundle/auto-pairs/plugin/auto-pairs.vim
setl nowrap
"setl comments^=:;;;,:;;,sr:#\|,mb:\|,ex:\|#
setl foldmethod=marker foldmarker=(,) foldminlines=1
setl lisp autoindent showmatch cpoptions-=mp
setl suffixesadd=.scm

nnoremap <buffer> <Leader>rb :w<CR>:!scm %:p <CR>
nnoremap <silent> <buffer> q :lclose \| pclose <CR>
autocmd BufWritePre *.scm silent g:CleanWhiteSpace()<CR>
