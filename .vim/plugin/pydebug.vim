finish

let s:plugin_root = escape( expand( '<sfile>:p' ), '\' )

python << EOF
import sys
import os
plugin_root = os.path.abspath(os.path.dirname(vim.eval("s:plugin_root")))
sys.path.insert(0, plugin_root)
from pudb import runscript

def pydebug():
    print 1
    script = vim.eval("expand('%:p')")
    print 2
    retval = runscript(script)
    print 3, retal

EOF
com DeeBug python pydebug()
