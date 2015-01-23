source ~/.vim/util.vim
call g:AddPythonPath('~/.vim/bundle/ropevim')
let defaultvirtualenv = $VIRTUAL_ENV
if getftype(defaultvirtualenv) == "dir"
    call LoadVirtualEnv(defaultvirtualenv)
endif

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
set clipboard=unnamed,unnamedplus
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
set expandtab
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
set bufhidden=hide
let mapleader = ','

syntax on

set rtp+=~/.vim/plugin
set rtp+=~/.vim/bundle/vundle/

source ~/.vim/bundles.vim
call singleton#enable()
let g:singleton#opener = 'drop'

if !singleton#is_master()
    let master = singleton#get_master()
    if master == ''
        call singleton#set_master(1)
    else
        silent! exe '!echo "Only one instance of vim may run at a time. (master=' . master . ')"'
        execute 'cquit!'
    endif
endif

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffWithSaved call s:DiffWithSaved()

function! OpenBrowser(url)
    execute "!open ". a:url
endfunction

function! WebSearch(term)
    let l:url = "https://www.google.com/?q=".a:term."\\\#q=".a:term
    call OpenBrowser(l:url)
endfunction

map <silent> <C-H> <C-W>h<C-W>_
map <silent> <C-J> <C-W>j<C-W>_
map <silent> <C-K> <C-W>k<C-W>_
map <silent> <C-L> <C-W>l<C-W>_
map <silent> <Leader>ts :set spell! spelllang=en_us<CR>
map <silent> <Leader>sv :source ~/.vimrc<CR>   
map <silent> <Leader>ev :e ~/.vimrc<CR>
map <silent> <Leader>tp :set paste!<CR>
map <silent> <Leader>tl :set list!<CR>
map <silent> <Leader>vh "zyiw:exe "h ".@z.""<CR>  " help for word under cursor
map <silent> <Leader>tt :TlistToggle<CR>
map <silent> <Leader>gs :call WebSearch(expand("<cword>"))<cr><cr>  " 'google' word under cursor
map <silent> <Leader>ol :call OpenBrowser(expand("<cWORD>"))<cr><cr>
map <silent> <Leader>nt :NERDTreeToggle<CR>
vmap <silent> > >gv
vmap <silent> < <gv

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

colorscheme grb256

"nnoremap <C-F1> :silent! !cmd.exe /c start keyhh.exe -\#klink "<C-R><C-W>" "$ASANY9\docs\dbmaen9.chm"<CR><CR>
"vnoremap <C-F1> :<C-U>let old_reg=@"<CR>gvy:silent!!cmd.exe /cstart keyhh.exe -\#klink "<C-R><C-R>"" ""$ASANY9\docs\dbmaen9.chm"<CR><CR>:let @"=old_reg<CR>:echo ""<CR>

augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END
function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")
        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'", "&Continue anyway?")
        endtry
    endif
endfunction

function! AskQuit (msg, proposed_action)
    if confirm(a:msg, "&Quit?\n" . a:proposed_action) == 1
        exit
    endif
endfunction

"let $PATH = 'blahblah:/usr/local/Cellar/reattach-to-user-namespace/2.3/bin' 
"vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

"http://vim.wikia.com/wiki/Paste_from_the_clipboard_into_a_new_vim
