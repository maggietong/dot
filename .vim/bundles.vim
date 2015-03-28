call vundle#rc()

Plugin 'simplyzhao/cscope_maps.vim'
Plugin 'autoload_cscope.vim'
Plugin 'Keithbsmiley/swift.vim'

"Plugin 'vivien/vim-addon-linux-coding-style'

Plugin 'gmarik/vundle'
Plugin 'thinca/vim-singleton'
let g:ycm_path_to_python_interpreter = GetRealPythonExecutablePath()
Plugin 'Valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_server_keep_logfiles = 1

Plugin 'python-rope/ropevim'
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
Plugin 'vim-scripts/taglist.vim'
Plugin 'tpope/vim-rsi'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'julienr/vimux-pyutils'
Plugin 'benmills/vimux'
Plugin 'ivyl/vim-bling'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'tpope/vim-fugitive'
"Plugin 'eldridgejm/tslime_ipython'
Plugin 'flazz/vim-colorschemes'
"Plugin 'qualiabyte/vim-colorstepper'
Plugin 'syngan/vim-vimlint'
Plugin 'ynkdir/vim-vimlparser'
Plugin 'jsatt/python_fn'
Plugin 'vim-scripts/python_match.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'jamessan/vim-gnupg'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-unimpaired'
Plugin 'luochen1990/rainbow'
" Disable auto-pairs. It's mostly just for scheme
let g:AutoPairsLoaded = 1
let g:AutoPairs = {}
Plugin 'jiangmiao/auto-pairs'
Plugin 'klen/python-mode'
let g:pymode = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_cmd = "import pudb; pudb.set_trace()     #import rpdb2; rpdb2.start_embedded_debugger('foo', fAllowRemote=True, timeout=rpdb2.TIMEOUT_FIVE_MINUTES*12) # BREAKPOINT"
""""""""""
""
""  It appears that g:pymode_breakpoint_cmd is *ignored*. Here's a pactch.
""
""""""""""
"#diff --git a/autoload/pymode/breakpoint.vim b/autoload/pymode/breakpoint.vim
"#index 18e1a95..dabb0fd 100644
"#--- a/autoload/pymode/breakpoint.vim
"#+++ b/autoload/pymode/breakpoint.vim
"#@@ -13,20 +13,6 @@ fun! pymode#breakpoint#init() "{{{
"#
"#     endif
"#
"#-        PymodePython << EOF
"#-
"#-from imp import find_module
"#-
"#-for module in ('pudb', 'ipdb'):
"#-    try:
"#-        find_module(module)
"#-        vim.command('let g:pymode_breakpoint_cmd = "import %s; %s.set_trace()  # XXX BREAKPOINT"' % (module, module))
"#-        break
"#-    except ImportError:
"#-        continue
"#-
"#-EOF
"#-
"# endfunction "}}}
"#
"# fun! pymode#breakpoint#operate(lnum) "{{{
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_folding = 0
let g:pymode_indent = 1
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pep8']
let g:pymode_lint_cwindow = 1
let g:pymode_lint_ignore = 'E501,W'
let g:pymode_lint_message = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_options_max_line_length = 119
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length, }
let g:pymode_lint_unmodified = 0
let g:pymode_lint_write = 0
let g:pymode_motion = 1
let g:pymode_quickfix_maxheight = 6
let g:pymode_quickfix_minheight = 3
let g:pymode_rope = 0
let g:pymode_run = 1
let g:pymode_run_bind = "<leader>PP"
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_trim_whitespaces = 1
let g:pymode_virtualenv = 0
let g:pymode_warnings = 1
