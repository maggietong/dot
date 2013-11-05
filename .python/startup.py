
try:
    import pudb as debugger
except ImportError:
    import pdb as debugger

st = debugger.set_trace

print '== imported', __file__
