
function! g:AddPythonPath(path)
    python import vim
    python new_path = vim.eval('a:path')
    if has("python")
        python << EOF
import os
import sys
path = os.path.expanduser(new_path)
if os.path.exists(path):
    sys.path.append(path)
EOF
    endif
endfunction

function! g:CleanWhiteSpace()
    :%s/\s\+$//e
    retab!
endfunction

" http://stackoverflow.com/questions/3881534/set-python-virtualenv-in-vim
function! LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

function! GetRealPythonExecutablePath()
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
path = os.path.join(prefix, 'bin', 'python')
vim.command('let %s = "%s"' % ('retval', path))
EOF
    endif
    return retval
endfunction
