" Wanted:
"  * a much easier way of doing visual replace
"  * a super easy way to in/undent python blocks. (or... have a command that selects the current inner-most block, then the next-outer, etc, etc. and cycles through them. It would then be possible to use >> / <<)
"  * a way to dynamically generate help (F1), preferabley w/ pythom
"  * shortcut for restarting that stupid server

"   ]t      -- Jump to beginning of block
"   ]e      -- Jump to end of block
"   ]v      -- Select (Visual Line Mode) block
"   ]<      -- Shift block to left
"   ]>      -- Shift block to right
"   ]#      -- Comment selection
"   ]u      -- Uncomment selection
"   ]c      -- Select current/previous class
"   ]d      -- Select current/previous function
"   ]<up>   -- Jump to previous line with the same/lower indentation
"   ]<down> -- Jump to next line with the same/lower indentation

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=119
set wildmenu
set ttyfast
set encoding=utf-8 nobomb
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
set modeline
set modelines=4
set cursorline
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
set hlsearch
set ignorecase
set incsearch
"set laststatus=2
set laststatus=0
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showmode
set title
set showcmd
set scrolloff=3
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
filetype plugin indent on
syntax on


set nofoldenable
set switchbuf+=useopen  " This is supposed to re-use open windows. Nope.
set wildmode=longest,list
"set tags=./tags,tags;$HOME
colorscheme advantage
set nocompatible              " be iMproved

filetype off                  " required by vundle (!?)
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'klen/python-mode'
Bundle 'jsatt/python_fn'
Bundle 'vim-scripts/python_match.vim'
Bundle 'L9'
Bundle 'FuzzyFinder'

"let g:virtualenv_loaded = 0
"let g:virtualenv_directory = '/Users/miburr/dot'
"let g:virtualenv_auto_activate = 1
let g:pymode_breakpoint = 1
let g:pymode_lint_write = 0
let g:pymode_run_key = 'E'
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
let g:pymode_lint_write = 0
let g:pymode_virtualenv = 1
let g:pymode_folding = 0
"let g:pymode_indent = []
let g:pymode_lint_onfly = 0
let g:pymode_lint_on_fly = 0
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

filetype plugin indent on     " required!

map <buffer> <C-P> :set paste <CR>
map <buffer> <C-A> :set nopaste <CR>

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <F5> :set spell! spelllang=en_us<CR>
map <buffer> <A-d> :Gdiff<CR>
map <buffer> <F3> :source ~/.vimrc <CR>
autocmd BufWritePre * :%s/\s\+$//e  " FIXME: not for all files.
map <buffer> <F8> :w<CR>:!pyflakes % <CR>
map <buffer> <F9> :w<CR>:!pep8 % <CR>
map <buffer> <S-e> :w<CR>:!/usr/bin/env python -u % <CR>
map <buffer> <S-t> :w<CR>:!/usr/bin/env python -m pudb.run % <CR><CR>

nmap <buffer> <F1> :!less ~/.vimrc<CR>
nmap <buffer> <C-S-y> :YcmRestartServer<CR>





"" works
"map <buffer> <F4> :echo 'works' <CR>
"map <buffer> <M-F4> :echo 'works' <CR>
"map <buffer> <S-F6> :echo 'works' <CR>
"map <buffer> UU :echo 'works' <CR>

"" N O N E   of these work!! (maybe they're os-mapped)
"map <buffer> <C-F6> :echo 'I suck' <CR>
"map <buffer> <T-F6> :echo 'I suck' <CR>
"map <buffer> <D-F6> :echo 'I suck' <CR>
"map <buffer> <M-C-F6> :echo 'I suck' <CR>
"map <buffer> <C-M-F6> :echo 'I suck' <CR>
"map <buffer> <S-M-F6> :echo 'I suck' <CR>
"map <buffer> <C-F3> :echo 'I suck' <CR>
"map <buffer> <A-v> :echo 'I suck' <CR>
"map <buffer> <M-v> :echo 'I suck' <CR>
