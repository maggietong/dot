import sys
import os
import re
import types
import logging
import __builtin__
import traceback
from glob import glob

_omnilog = logging.getLogger('omnilog')
log_file_path = '/tmp/global_python_log.log'
fh = logging.FileHandler(log_file_path)
#file_formatter = logging.Formatter('%(levelname)-4s %(message)s')
file_formatter = logging.Formatter('%(message)s')
fh.setFormatter(file_formatter)
fh.setLevel(logging.DEBUG)
_omnilog.addHandler(fh)

class OmniLogger(object):
    levels = {
        'd': logging.DEBUG,
        'i': logging.INFO,
        'w': logging.WARN,
        'e': logging.ERROR,
        'c': logging.CRITICAL,
    }

    def __init__(self, real_logger):
        for name in dir(real_logger):
            if name.startswith('_'):
                continue
            value = getattr(real_logger, name)
            setattr(self, name, value)

    def sl(self, level):
        l = self.levels.get(level)
        if l is not None:
            level = l
        self.setLevel(level)

    def l0g(self, *args):
        self.setLevel(logging.DEBUG)
        import inspect
        func = inspect.currentframe().f_back.f_code
        pref = '{0}:{1}({2})'.format(func.co_filename, func.co_name, func.co_firstlineno)
        def sify(s):
            if isinstance(s, basestring):
                return s
            return str(s)
        msg = ' ' .join([sify(i) for i in [pref] + list(args)])
        info = getattr(self, 'info')
        info(msg)

    __call__ = l0g

omnilog = OmniLogger(_omnilog)

__builtin__.omnilog = omnilog
__builtin__.og = omnilog
__builtin__.ol = omnilog


#projects_base = os.path.expanduser('~/git/stnbu')
#for path in glob(os.path.join(projects_base, '*')):
#    if os.path.isdir(path):
#        sys.path.append(path)


def enable_debug_hook():
    try:
        import pudb

        original_hook = sys.excepthook
        def my_exception_hook(type, value, tb):
            bail_conditions = [
                not sys.stderr.isatty(),
                not sys.stdin.isatty(),
                type is KeyboardInterrupt,
            ]
            for index, condition in enumerate(bail_conditions):
                if condition:
                    print >>sys.stderr, 'BECAUSE OF', index
                    original_hook(type, value, tb)
                    break
            else:
                estring = traceback.format_exception(type, value, tb)
                estring = [l for l in estring if l.strip()]
                estring = ['   EXCEPTION:  ' + l for l in estring]
                estring.insert(0, 'An exception occured:\n')
                estring = '\n'.join(estring)
                estring = re.sub('[\n\r]+', os.linesep, estring)
                omnilog.error(estring)
                pudb.pm()
        sys.excepthook = my_exception_hook
    except ImportError:
        pass

enable_debug_hook()

for p in '/Users/miburr/git/stnbu/direg', '/Users/miburr/git/stnbu/pynaut':
    if p in sys.path:
        sys.path.remove(p)

