
let s:plugin_root = escape(expand('<sfile>:p'), '\')

python << EOS
import sys
import os
import vim
plugin_root = os.path.abspath(os.path.dirname(vim.eval("s:plugin_root")))
sys.path.insert(0, plugin_root)
import vimlib
EOS

map <Leader>sm :python vimlib.output_to_window(vimlib.get_menu())<CR>

