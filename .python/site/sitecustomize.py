# code snippet, to be included in 'sitecustomize.py'
try:
    import pudb as debugger
except ImportError:
    import pdb as debugger

import traceback
import sys

sys.modules['s'] = sys.modules[__name__]

st = debugger.set_trace

def drop_debugger(type, value, tb):
  traceback.print_exception(type, value, tb)
  debugger.pm()

sys.excepthook = drop_debugger


frame = sys._getframe(0) # .f_back.f_locals.update(enums)
frame.f_globals['foo'] = '999' * 100

import site
site.ENABLE_USER_SITE = True

print '== imported', __file__
