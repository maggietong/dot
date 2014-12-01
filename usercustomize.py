
try:
    import pudb
    import pdb
    import sys
    pudb.Pdb = pdb.Pdb
    pudb.Restart = pdb.Restart
    sys.modules['pdb'] = pudb
except ImportError:
    pass
