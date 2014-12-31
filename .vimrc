

if ! exists('loaded_less')
    let loaded_less = 0
endif

let python_highlight_all = 1

"if loaded_less == 1
"endif

set nocompatible

filetype off
filetype plugin indent on

set number
set shiftwidth=4
"set tabstop=4
"set expandtab
set textwidth=119
set nofoldenable
set wildmenu
set ttyfast
set encoding=utf-8 nobomb
set noswapfile
"if loaded_less == 1
"    set noswapfile
"else
"    set backupdir=~/.vim/backups
"    set directory=~/.vim/swaps
"    set undodir=~/.vim/undo
"endif
set modeline
set modelines=4
set cursorline
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
set hlsearch
set ignorecase
set smartcase
set incsearch
set laststatus=2
set noerrorbells
set nostartofline
set verbose=1
set verbosefile=~/.vim/logs/verbose.log
set ruler
set shortmess=atI
set showmode
set title
set showcmd
set scrolloff=3
set switchbuf+=useopen
set wildmode=longest,list
"set autochdir
"set tags=./tags;~
"set tags=./tags,tags;
"set tags=./tags;/
set tags=./tags,tags,~/virtualenv/**/tags,/usr/local/Cellar/python*/**/tags,~/git/mainline/**/tags
set bufhidden=hide

let mapleader = ','

syntax on

set rtp+=~/.vim/plugin
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/taglist.vim'
let Tlist_Use_Horiz_Window=1

Bundle 'ivyl/vim-bling'
Bundle 'ivanov/ipython-vimception'
Bundle 'eldridgejm/tslime_ipython'
Bundle 'flazz/vim-colorschemes'
Bundle 'qualiabyte/vim-colorstepper'
Bundle 'Valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_server_keep_logfiles = 1
Bundle 'syngan/vim-vimlint'
Bundle 'ynkdir/vim-vimlparser'
Bundle 'jsatt/python_fn'
Bundle 'vim-scripts/python_match.vim'
Bundle 'klen/python-mode'
let g:pymode_options_max_line_length = 119
Bundle 'itchyny/lightline.vim'
"Bundle 'jmcantrell/vim-virtualenv'
Bundle 'jamessan/vim-gnupg'
"let g:virtualenv_auto_activate = 1
"let g:virtualenv_directory = "$HOME/virtualenv"
Bundle 'scrooloose/nerdtree'
"let NERDTreeBookmarksFile = "$HOME/.vim/nerdtree_bookmarks"

let NERDTreeQuitOnOpen = 1

"http://blog.ant0ine.com/typepad/2007/03/ack-and-vim-integration.html
"Bundle 'mileszs/ack.vim'
"Bundle 'vim-scripts/vcscommand.vim'


"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'tomtom/tlib_vim'
"Bundle 'garbas/vim-snipmate'
"Bundle 'honza/vim-snippets'

Bundle 'tpope/vim-fugitive'

"Bundle 'Shougo/vimshell.vim'
"Bundle 'Shougo/vimproc.vim'

let g:pymode = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_lint = 1
let g:pymode_virtualenv = 0
let g:virtualenv_loaded = 1
let g:pymode_lint_message = 0
let g:pymode_lint_cwindow = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pep257', 'pylint']
let g:pymode_lint_write = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_ignore = 'E501,W'
let g:pymode_rope = 0
let g:pymode_breakpoint = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_run_key = "<C-S-6>"
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
let g:pymode_run_bind = "<C-S-6>"

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
    "retab
endfunction

function! OpenBrowser(url)
    execute "!open ". a:url
endfunction

function! WebSearch(term)
    let l:url = "https://www.google.com/?q=".a:term."\\\#q=".a:term
    call OpenBrowser(l:url)
endfunction

map <C-H> <C-W>h<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <Leader>ts :set spell! spelllang=en_us<CR>
map <Leader>sv :source ~/.vimrc<CR>   
map <Leader>ev :e ~/.vimrc<CR>
map <Leader>hh :h stnbu<CR>
map <Leader>tp :set paste!<CR>
map <Leader>tl :set list!<CR>
map <Leader>vh "zyiw:exe "h ".@z.""<CR>  " help for word under cursor
map <Leader>tt :TlistToggle<CR>
map <silent> <Leader>gs :call WebSearch(expand("<cword>"))<cr><cr>  " 'google' word under cursor
map <silent> <Leader>ol :call OpenBrowser(expand("<cWORD>"))<cr><cr>
map <Leader>nt :NERDTreeToggle<CR>
vmap > >gv
vmap < <gv

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified'
      \ },
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "RO"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

highlight Folded ctermbg=0
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg2 --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END


function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

au BufRead,BufNewFile *.ipy set filetype=python

hi clear SpellBad
hi SpellBad term=reverse ctermbg=Yellow gui=undercurl guisp=Yellow


"let g:ycm_server_log_level = 'debug'
