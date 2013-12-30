
let s:plugin_root = escape( expand( '<sfile>:p' ), '\' )

python << EOF
import sys
import os
plugin_root = os.path.abspath(os.path.dirname(vim.eval("s:plugin_root")))
sys.path.insert(0, plugin_root)
import vim_git
EOF

"fun! VimGitShowReport()
"    let l:file = expand('%:p')
"    pclose
"    exe "botright 8new _gitreport_"
"    setlocal buftype=nofile bufhidden=delete noswapfile nowrap previewwindow
"    redraw
"    python vim_git.repo_report(vim.eval("l:file"))
"    setlocal nomodifiable
"    setlocal nomodified
"    setlocal filetype=rst
"    wincmd p
"endfunction
"
