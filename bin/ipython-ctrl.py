#!/usr/bin/env python2.7

import os
import sys

os.unsetenv('PAGER')

sys.path.insert(0, os.path.expanduser('~/.ipython/'))

import monkeypatches.consoleapp
from IPython import consoleapp

# MONKEYPATCHIN
consoleapp.IPythonConsoleApp.init_kernel_manager = monkeypatches.consoleapp._init_kernel_manager
###


from signal import SIGTERM
from IPython import start_kernel
from IPython.html.notebookapp import NotebookApp
from daemon.runner import DaemonRunner
from IPython.terminal.console import app as consoleapp
from IPython import get_ipython

GLOBAL_DEBUG = bool(os.getenv('IPYTHON_GLOBAL_DEBUG', False))

nbapp = None


def get_notebook_app(argv=[]):
    global nbapp
    if nbapp is not None:
        return nbapp
    nbapp = NotebookApp(argv=argv)
    nbapp.info_file = '/Users/miburr/git/stnbu/dot/.ipython/profile_default/security/nbserver-default.json'
    nbapp.initialize(argv=[])
    #nbapp.write_server_info_file()
    nbapp.start()
    from IPython.parallel import bind_kernel
    l = bind_kernel()
    print(dir(l))
    print(type(l))
    return nbapp

class IPythonDaemonApp(object):

    def __init__(self, profile, type, argv=[], debug=False):

        self.type = type
        self.profile = profile
        self.debug = debug

        self.argv = argv

        homedir = os.path.expanduser('~')
        ipython_dir = os.path.join(homedir, '.ipython')
        profile_dir = os.path.join(ipython_dir, 'profile_{0}'.format(self.profile))
        io_dir = os.path.join(profile_dir, self.type, 'io')

        for dir in io_dir, os.path.join(profile_dir, 'pid'):
            if not os.path.exists(dir):
                os.makedirs(dir)

        self.stdin_path = '/dev/null'
        self.stdout_path = os.path.join(io_dir, 'out')
        self.stderr_path = os.path.join(io_dir, 'err')
        self.pidfile_path = os.path.join(profile_dir, 'pid', '{0}-daemon.pid'.format(self.type))
        self.pidfile_timeout = 30

        if not self.argv:
            self.argv = []
            self.argv.append('ipython')
            self.argv.append(self.type)
            self.argv.append('--pydb')
            self.argv.append('--profile={0}'.format(self.profile))

        if self.debug:
            self.argv.append('--debug')

        if self.type == 'kernel':
            self.starter = start_kernel
        elif self.type == 'notebook':
            if '--pydb' in self.argv:
                self.argv.remove('--pydb')
            self.starter = get_notebook_app
        elif self.type == 'console':
            if '--debug' in self.argv:
                self.argv.remove('--debug')
            self.argv.append('-i')
            self.argv.append('--classic')
            self.stdin_path = sys.stdin
            self.stdout_path = sys.stdout
            self.stderr_path = sys.stderr
            self.starter = consoleapp.launch_new_instance
        else:
            raise ValueError('Not yet alble to deal with "{0}"'.format(self.type))

    def shutdown_kernel(self):
        s = get_ipython()
        if s is None:
            return None
        while True:
            if s.parent is None:
                break
            s = s.parent
        pid = s.session.pid
        return os.kill(pid, SIGTERM)

    def run(self):
        return self.starter(argv=self.argv)


if __name__ == '__main__':

    def useage():
        print '{0}: read it!\n'.format(os.path.abspath(__file__))

    try:
        type = sys.argv.pop(1).strip().lower()
    except IndexError:
        useage()
        sys.exit(1)

    if len(sys.argv) <= 3:
        sys.argv.append('start')

    action = sys.argv[1].strip().lower()

    if type not in ('kernel', 'notebook', 'console', 'all-headless'):
        useage()
        sys.exit(1)

    if type in ['kernel']:
        print "good news. you probably don't need kernel anymore"

    if type == 'all-headless':
        type = ['kernel', 'notebook']

    def start(type):
        app = IPythonDaemonApp(profile='default', type=type, debug=GLOBAL_DEBUG)
        if type in ('console',):
            sys.exit(app.run())
        d = DaemonRunner(app)
        d.do_action()

    if action == 'start':
        if not isinstance(type, (tuple, list)):
            type = [type]
        for t in type:
            start(type=t)
    elif action == 'stop':
        print 'so sorry'
        print 'try: kill $(cat ~/.ipython/profile_default/pid/kernel-daemon.pid)'
        print 'and so forth'
    else:
        print 'I do not play that'
