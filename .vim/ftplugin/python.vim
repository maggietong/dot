""" :setlocal

source ~/.vim/util.vim

set showcmd
set formatoptions=tcroqa
set nowrap
set define=^\s*\\(def\\\\|class\\)

nnoremap <silent> <buffer> <Leader>rl :PymodeLint<CR>
nnoremap <buffer> <Leader>rb :w<CR>:!python %:p <CR>
nnoremap <buffer> <Leader>rd :w<CR>:!python -m pudb.run %:p <CR><CR>
nnoremap <silent> <buffer> q :lclose \| pclose <CR>

let defaultvirtualenv = $VIRTUAL_ENV
if getftype(defaultvirtualenv) == "dir"
    call LoadVirtualEnv(defaultvirtualenv)
endif

autocmd FocusLost *.py : if &modified
autocmd FocusLost *.py : write
autocmd FocusLost *.py : echo "Autosaved file while you were absent"
autocmd FocusLost *.py : endif

autocmd BufWritePre *.py silent g:CleanWhiteSpace()<CR>

let s:py_active_left = [ 've_status', 'py_loc' ]
let s:py_component_function = {
\ 'py_loc': 'TagInStatusLine',
\}

call extend(g:lightline.component_function, s:py_component_function)
call add(g:lightline.active.left, s:py_active_left)
