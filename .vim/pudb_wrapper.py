#!/usr/bin/env python

import sys
import os

def usage():
    return '{} <python_script>'.format(os.path.basename(__file__))

try:
    with open(sys.argv[1], 'rb') as pyfile:
        exec(pyfile.read())
except IndexError:
    print usage()
except Exception as e:
    try:
        from pudb import post_mortem
        post_mortem()
    except ImportError:
        print >>sys.stderr, '\n   >>> Try installing pudb! <<<\n'
        raise e
