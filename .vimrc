" https://github.com/davidhalter/jedi-vim
" https://github.com/klen/python-mode#default-keys


"""" Things to get in the habit of:
"  g~iw -- toggle case of current word
"  ]X -- navigate through python's blocks (for various 'X')
"  yiw -- yank current word (Yank In Word)
"  c (in visual mode) -- *replace* selected text
"  * -- jump to the next match of word under cursor
"  % -- jump to corresponding closing paren, etc
"  cw -- change word. Delete the remainder of current word and jump to insert mode
"  ctrl-n -- completion
"  Define 'abbr' for anything you frequently mistype
"  tags...stuff

"""" Efficiency to-dos:
"  various macros, func/class skeletons, etc.
"  spell checking
"  select, replace a current word
"  syncronize WM, vim clipboards
"  highlight undefined... etc. Some kind of real-time use of pyflakes.
"  macro to 'split string, <CR>' when the string is inside of ()
"  find a nice way to wrap all vim customizations with one python call.
"  do something better with TODO and FIXME ...maybe a red underline.
"  host vim crap somewhere ...github
"  stop using iterm windows. Use buffers instead. Learn to yank/paste between buffers

"""" Folding
" zf#j creates a fold from the cursor down # lines.
" zf/string creates a fold from the cursor to string .
" zj moves the cursor to the next fold.
" zk moves the cursor to the previous fold.
" zo opens a fold at the cursor.
" zO opens all folds at the cursor.
" zm increases the foldlevel by one.
" zM closes all open folds.                                      <--------!
" zr decreases the foldlevel by one.
" zR decreases the foldlevel to zero -- all folds will be open.  <---------!
" zd deletes the fold at the cursor.
" zE deletes all folds.
" [z move to start of open fold.
" ]z move to end of open fold.

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=119

map <F5> :set spell! spelllang=en_us<CR>

set nocompatible
"set clipboard=unnamed
set wildmenu
set ttyfast
set gdefault
set encoding=utf-8 nobomb
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
set modeline
set modelines=4
set cursorline
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
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


" Rember location
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

autocmd filetype sh source ~/.vim/sh.vim
autocmd BufRead,BufNewFile */test_*.py source ~/.vim/nose.vim

filetype off

let g:pathogen_disabled = []
"call add(g:pathogen_disabled, '')
execute pathogen#infect('~/.vim_bundles/{}')

call pathogen#helptags()

filetype plugin indent on
syntax on

let g:virtualenv_loaded = 0
let g:virtualenv_directory = '/Users/miburr/dot'
let g:virtualenv_auto_activate = 1

let g:pymode_lint_write = 0
let g:pymode_run_key = 'E'
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
let g:pymode_lint_onfly = 0
let g:pymode_lint_write = 0
let g:pymode_virtualenv = 1

set nofoldenable

autocmd filetype python source ~/.vim/mypystuff.vim
autocmd filetype sh source ~/.vim/sh.vim
autocmd BufRead,BufNewFile */test_*.py source ~/.vim/nose.vim
