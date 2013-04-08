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

execute pathogen#infect()

syntax on

":highlight Comment ctermfg=green
":highlight Constant ctermfg=white

"colorscheme skittles_berry

set modeline
set ruler
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=119

""set spell spelllang=en_us
map <F5> :set spell! spelllang=en_us<CR>

set formatoptions+=l

filetype plugin indent on
filetype plugin on

set incsearch
set hlsearch

"if !exists("autocommands_loaded")
"  let autocommands_loaded = 1
"  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vim
"endif

" Rember location
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

autocmd filetype python source ~/.vim/python.vim
autocmd filetype python source ~/.vim/pythonloc.vim  " Show location in py file
autocmd filetype python source ~/.vim/mypystuff.vim  " My python stuff
autocmd filetype python source ~/.vim/python_fn.vim  " Enhanced navigation
autocmd filetype sh source ~/.vim/sh.vim
autocmd BufRead,BufNewFile */test_*.py source ~/.vim/nose.vim
