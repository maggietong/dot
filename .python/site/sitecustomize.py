# code snippet, to be included in 'sitecustomize.py'
try:
    import sys

    def info(type, value, tb):
       if hasattr(sys, 'ps1') or not sys.stderr.isatty():
          import traceback, pudb
          traceback.print_exception(type, value, tb)
          pudb.pm()
          #sys.__excepthook__(type, value, tb)
       else:
          import traceback, pudb
          traceback.print_exception(type, value, tb)
          pudb.pm()

    sys.excepthook = info

except ImportError:
    pass
