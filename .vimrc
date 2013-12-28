set nocompatible

filetype off
filetype plugin indent on

set number
set shiftwidth=4
set tabstop=8
set expandtab
set textwidth=119
set nofoldenable
set wildmenu
set ttyfast
set encoding=utf-8 nobomb
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
set modeline
set modelines=4
set cursorline
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showmode
set title
set showcmd
set scrolloff=3
set switchbuf+=useopen  " This is supposed to re-use open windows. Nope.
set wildmode=longest,list
set autochdir

syntax on

set rtp+=~/.vim/plugin
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'ivyl/vim-bling'
Bundle 'flazz/vim-colorschemes'
Bundle 'qualiabyte/vim-colorstepper'
Bundle 'Valloric/YouCompleteMe'
verbose nmap <buffer> <C-M-y> :YcmRestartServer<CR>
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_cache_omnifunc = 0
Bundle 'syngan/vim-vimlint'
Bundle 'ynkdir/vim-vimlparser'
Bundle 'jsatt/python_fn'
Bundle 'vim-scripts/python_match.vim'
Bundle 'klen/python-mode'

let g:pymode = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_lint = 0
let g:pymode_lint_message = 0
let g:pymode_lint_cwindow = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pep257']
let g:pymode_lint_write = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_ignore = 'E501,W'
let g:pymode_rope = 0
let g:pymode_breakpoint = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_run_key = 'E'
let g:pymode_folding = 0
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_options = 1
let g:pymode_quickfix_maxheight = 6
let g:pymode_quickfix_minheight = 3
let g:pymode_run = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_warnings = 1
let g:pymode_lint_on_write = 0
let g:pymode_lint_unmodified = 0


function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffWithSaved call s:DiffWithSaved()

function! g:CleanWhiteSpace()
    :%s/\s\+$//e
endfunction

verbose map <buffer> <C-P> :set paste <CR>
verbose map <buffer> <C-A> :set nopaste <CR>
verbose map <C-H> <C-W>h<C-W>_
verbose map <C-J> <C-W>j<C-W>_
verbose map <C-K> <C-W>k<C-W>_
verbose map <C-L> <C-W>l<C-W>_
verbose map <F5> :set spell! spelllang=en_us<CR>
verbose map <F3> :source ~/.vimrc<CR>
verbose map <F1> :!less ~/.vimrc<CR>
