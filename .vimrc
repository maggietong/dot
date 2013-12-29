set nocompatible

filetype off
filetype plugin indent on

set number
set shiftwidth=4
set tabstop=4
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
set switchbuf+=useopen
set wildmode=longest,list
"set autochdir
set tags=./tags;~

set bufhidden=hide

syntax on

set rtp+=~/.vim/plugin
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/taglist.vim'
let Tlist_Use_Horiz_Window=1

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
Bundle 'itchyny/lightline.vim'

let g:pymode = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_lint = 1
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

function! OpenBrowser(word)
    let l:url = "https://www.google.com/?q=".a:word."\\\#q=".a:word
    execute "!open ". l:url
endfunction

map <unique> <C-H> <C-W>h<C-W>_
map <unique> <C-J> <C-W>j<C-W>_
map <unique> <C-K> <C-W>k<C-W>_
map <unique> <C-L> <C-W>l<C-W>_
map <unique> ,ts :set spell! spelllang=en_us<CR>
map <unique> ,sv :source ~/.vimrc<CR>   
map <unique> ,ev :e ~/.vimrc<CR>
map <unique> ,hh :h stnbu<CR>
map <unique> ,tp :set paste!<CR>
map <unique> ,tl :set list!<CR>
map <unique> ,vh "zyiw:exe "h ".@z.""<CR>  " help for word under cursor
map <unique> ,gs :call OpenBrowser(expand("<cword>"))<cr><cr>  " 'google' word under cursor


"exe "nnoremap <silent> <buffer> " g:pymode_run_bind ":PymodeRun<CR>"
"
"*:PymodeLint* -- Check code in current buffer
"*:PymodeDoc* <args> — show documentation 
