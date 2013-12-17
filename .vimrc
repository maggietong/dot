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

set nocompatible

filetype off
filetype plugin indent on

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
set switchbuf+=useopen  " This is supposed to re-use open windows. Nope.
set wildmode=longest,list
"set tags=./tags,tags;$HOME
colorscheme advantage

syntax on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'Valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_cache_omnifunc = 0
verbose nmap <buffer> <C-M-y> :YcmRestartServer<CR>

set nofoldenable
Bundle 'jsatt/python_fn'
Bundle 'vim-scripts/python_match.vim'
Bundle 'pythonhelper'
Bundle 'klen/python-mode'

let g:pymode = 1
"let g:pymode_debug = 0
"let g:pymode_doc' = 1
"let g:pymode_doc_bind = 'K'
let g:pymode_lint_message = 0
let g:pymode_lint_cwindow = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pep257']
let g:pymode_lint_write = 0
let g:pymode_lint_on_fly = 0
"let g:pymode_lint_ignore = 'E501,W'
let g:pymode_rope = 0
let g:pymode_breakpoint = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_run_key = 'E'
"let g:pymode_virtualenv = 1
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
verbose map <buffer> <F8> :w<CR>:!pyflakes % <CR>
verbose map <buffer> <F9> :w<CR>:!pep8 % <CR>
verbose map <buffer> <S-e> :w<CR>:!/usr/bin/env python -u % <CR>
verbose map <buffer> <S-t> :w<CR>:!/usr/bin/env python -m pudb.run % <CR><CR>
"Bundle 'scrooloose/syntastic'

Bundle 'syngan/vim-vimlint'
Bundle 'ynkdir/vim-vimlparser'
"Bundle 'jaredly/vim-debug'

Bundle 'tpope/vim-fugitive'
verbose map <unique> ,gd :Gdiff<CR>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffWithSaved call s:DiffWithSaved()

function! CleanWhilespace()
    :%s/\s\+$//e
endfunction
autocmd BufWritePre * call CleanWhilespace()

verbose map <buffer> <C-P> :set paste <CR>
verbose map <buffer> <C-A> :set nopaste <CR>
verbose map <C-H> <C-W>h<C-W>_
verbose map <C-J> <C-W>j<C-W>_
verbose map <C-K> <C-W>k<C-W>_
verbose map <C-L> <C-W>l<C-W>_
verbose map <F5> :set spell! spelllang=en_us<CRs ~/.vimrc<CR>>
verbose map <buffer> <F3> :source ~/.vimrc <CR>
verbose nmap <buffer> <F1> :!less ~/.vimrc<CR>
verbose nmap <buffer> <F9> :PymodeLintAuto <CR>
"""" PymodeLint



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""  :buffers[!]					*:buffers* *:ls*

""""  :[N]bn[ext][!] [N]					*:bn* *:bnext* *E87*
""""  		Go to [N]th next buffer in buffer list.  [N] defaults to one.
""""  		Wraps around the end of the buffer list.

""""  :[N]b[uffer][!] [N]			*:b* *:bu* *:buf* *:buffer* *E86*
""""  		Edit buffer [N] from the buffer list.  If [N] is not given,
""""  		the current buffer remains being edited.  See |:buffer-!| for
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""  :[count]tabnew [++opt] [+cmd] {file}
""""  		Open a new tab page and edit {file}, like with |:edit|.
""""  		For [count] see |:tab| below.
""""  :tabc[lose][!]	Close current tab page.
""""  :tabo[nly][!]	Close all other tab pages.
""""  :tabn[ext]				*:tabn* *:tabnext* *gt*
""""  :tabp[revious]				*:tabp* *:tabprevious* *gT* *:tabN*
""""  :tabfir[st]	Go to the first tab page.
""""  :tabl[ast]	Go to the last tab page.
""""  :tabd[o] {cmd}	Execute {cmd} in each tab page.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"function! LastWinWasQuickfix()
"    if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"
"        return 1
"    endif
"    return 0
"endfunction
"aug QFClose
"  au!
"  au WinEnter * echo 'blaaaaaaah'
"aug END


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

""""						*skeleton* *template*
"To read a skeleton (template) file when opening a new file: >
"  :autocmd BufNewFile  *.c	0r ~/vim/skeleton.c
"  :autocmd BufNewFile  *.h	0r ~/vim/skeleton.h
"  :autocmd BufNewFile  *.java	0r ~/vim/skeleton.java
