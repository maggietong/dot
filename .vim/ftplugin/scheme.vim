source ~/.vim/util.vim

unlet g:AutoPairsLoaded
au Filetype scheme let b:AutoPairs = {"(": ")", "[": "]"}

source ~/.vim/bundle/auto-pairs/plugin/auto-pairs.vim
setl nowrap
"setl comments^=:;;;,:;;,sr:#\|,mb:\|,ex:\|#
setl foldmethod=marker foldmarker=(,) foldminlines=1
setl lisp autoindent showmatch cpoptions-=mp
setl suffixesadd=.scm

nnoremap <buffer> <Leader>rb :w<CR>:!scm -c %:p <CR>
nnoremap <silent> <buffer> q :lclose \| pclose <CR>
autocmd BufWritePre *.scm silent g:CleanWhiteSpace()<CR>

function! OpenBrowser(url)
    execute "!open ". a:url
endfunction

function! GetSchemeTerm(term)
    let l:url = "http://docs.racket-lang.org/guide/".a:term.".html"
    call OpenBrowser(l:url)
endfunction

map <silent> <Leader>ww :call GetSchemeTerm(expand("<cword>"))<cr><cr>
