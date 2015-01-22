
function! ArgvContains(substring)
    return (stridx(system("ps -o command= -p" . getpid()), a:substring) != -1)
endfunction
function! ArgvHasServername()
    return ArgvContains('--servername')
endfunction
if !ArgvHasServername()
    silent! exe '!echo "The --servername option is required."'
    execute 'cquit!'
endif
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * :let v:swapchoice = 'q'
augroup END

set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

let python_highlight_all = 1
set nocompatible
filetype off
filetype plugin indent on
set number
set shiftwidth=4
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
set tags=./tags,tags,~/virtualenv/**/tags,/usr/local/Cellar/python*/**/tags,~/git/mainline/**/tags
set bufhidden=hide
let mapleader = ','

syntax on

" http://stackoverflow.com/questions/3881534/set-python-virtualenv-in-vim
function LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction
if has("python")
    let defaultvirtualenv = $VIRTUAL_ENV
    if getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif

set rtp+=~/.vim/plugin
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'thinca/vim-singleton'
call singleton#enable()
let master = singleton#get_master()
if master == ''
    call singleton#set_master(1)
else
    silent! exe '!echo "Only one instance of vim may run at a time. (master=' . master . ')"'
    execute 'cquit!'
endif

Bundle 'Valloric/YouCompleteMe'
" YCM needs the 'real' binary path (e.g. when python is in a virtualenv.)
" set it here as best we can:
if has("python")
python << EOF
import os
import sys
import subprocess
import vim
cmd = ('''python -c '''
       '''"import sys ;'''
       '''pref = sys.prefix if not hasattr(sys, 'real_prefix') else sys.real_prefix ;'''
       '''print(pref)"''')
prefix = subprocess.check_output(cmd, shell=True)
prefix = prefix.strip()
cmd = 'let %s = "%s"' % ('g:ycm_path_to_python_interpreter', os.path.join(prefix, 'bin', 'python'))
vim.command(cmd)
EOF
endif
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_server_keep_logfiles = 1

Bundle 'vim-scripts/taglist.vim'
Bundle 'ivyl/vim-bling'
Bundle 'ivanov/ipython-vimception'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'tpope/vim-fugitive'
Bundle 'eldridgejm/tslime_ipython'
Bundle 'flazz/vim-colorschemes'
Bundle 'qualiabyte/vim-colorstepper'
Bundle 'syngan/vim-vimlint'
Bundle 'ynkdir/vim-vimlparser'
Bundle 'jsatt/python_fn'
Bundle 'vim-scripts/python_match.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'jamessan/vim-gnupg'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-unimpaired'
Bundle 'klen/python-mode'
let g:pymode_options_max_line_length = 119
let g:pymode = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_lint = 1
let g:pymode_virtualenv = 0
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

if has("python")
python << EOF
## sad, ugly hack
import os
import sys
path = os.path.expanduser('/Users/miburr/.vim/bundle/ropevim')
if os.path.exists(path):
    sys.path.append(path)
EOF
endif
Bundle 'python-rope/ropevim'
let ropevim_extended_complete=1
let ropevim_vim_completion=1
let ropevim_codeassist_maxfixes = 1
let ropevim_enable_shortcuts = 1
let ropevim_guess_project = 1
let ropevim_enable_autoimport = 1
let g:ropevim_autoimport_modules = [
    \ "StringIO",
    \ "argparse",
    \ "copy",
    \ "datetime",
    \ "glob",
    \ "imp",
    \ "itertools",
    \ "logging",
    \ "os",
    \ "pprint",
    \ "pudb",
    \ "random",
    \ "re",
    \ "shutil",
    \ "subprocess",
    \ "sys",
    \ "tempfile",
    \ "time",
    \ "types"]
let ropevim_autoimport_underlineds = 0
let ropevim_goto_def_newwin = 1

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

augroup encrypted
  au!
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg2 --decrypt 2> /dev/null
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
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

"hi clear SpellBad
"hi SpellBad term=reverse ctermbg=Yellow gui=undercurl guisp=Yellow
colorscheme gardener
