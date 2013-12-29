
""" :setlocal

nnoremap <silent> <buffer> ,pp :echo 'peeeppeeee'<CR>
nnoremap <silent> <buffer> ,rl :PymodeLint<CR>
nnoremap <silent> <buffer> ,rb :PymodeRun<CR>
nnoremap <buffer> ,rd :w<CR>:!/usr/bin/env new_debug_window python -m pudb.run %:p <CR><CR>



"*:PymodeLintAuto* -- Fix PEP8 errors in current buffer automatically
"map <buffer> 'rb :w<CR>:!/usr/bin/env python -u % <CR>
"map <buffer> 'rb :w<CR>:!/usr/bin/env python -u % <CR>

function! b:PyCleanWhiteSpace()
    call g:CleanWhiteSpace()
    :%s/\s\+$//e
    retab
endfunction

"map <buffer><silent> <F8> :call b:PyCleanWhiteSpace()<CR>
autocmd BufWritePre *.py call b:PyCleanWhiteSpace()

"exe "nnoremap <silent> <buffer> " g:pymode_run_bind ":PymodeRun<CR>"
"exe "vnoremap <silent> <buffer> " g:pymode_run_bind ":PymodeRun<CR>"
"exe "nnoremap <silent> <buffer> " g:pymode_breakpoint_bind ":call pymode#breakpoint#operate(line('.'))<CR>"
"exe "nnoremap <silent> <buffer> " g:pymode_doc_bind ":call pymode#doc#find()<CR>"
"exe "vnoremap <silent> <buffer> " g:pymode_doc_bind ":<C-U>call pymode#doc#show(@*)<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_goto_definition_bind . " :call pymode#rope#goto_definition()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_show_doc_bind . " :call pymode#rope#show_doc()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_find_it_bind . " :call pymode#rope#find_it()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_organize_imports_bind . " :call pymode#rope#organize_imports()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_rename_bind . " :call pymode#rope#rename()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_rename_module_bind . " :call pymode#rope#rename_module()<CR>"
"exe "vnoremap <silent> <buffer> " . g:pymode_rope_extract_method_bind . " :call pymode#rope#extract_method()<CR>"
"exe "vnoremap <silent> <buffer> " . g:pymode_rope_extract_variable_bind . " :call pymode#rope#extract_variable()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_inline_bind . " :call pymode#rope#inline()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_move_bind . " :call pymode#rope#move()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_change_signature_bind . " :call pymode#rope#signature()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_use_function_bind . " :call pymode#rope#use_function()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_generate_function_bind . " :call pymode#rope#generate_function()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_generate_package_bind . " :call pymode#rope#generate_package()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_generate_class_bind . " :call pymode#rope#generate_class()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_module_to_package_bind . " :call pymode#rope#module_to_package()<CR>"
"exe "noremap <silent> <buffer> " . g:pymode_rope_autoimport_bind . " :PymodeRopeAutoImport<CR>"
"inoremap <silent> <buffer> . .<C-R>=pymode#rope#complete_on_dot()<CR>

