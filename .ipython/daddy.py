#Embedded file name: daddy.py
import atexit
import os
import signal
import sys
import uuid
from IPython.config.application import boolean_flag
from IPython.core.profiledir import ProfileDir
from IPython.kernel.blocking import BlockingKernelClient
from IPython.kernel import KernelManager
from IPython.kernel import tunnel_to_kernel, find_connection_file, swallow_argv
from IPython.kernel.kernelspec import NoSuchKernel
from IPython.utils.path import filefind
from IPython.utils.traitlets import Dict, List, Unicode, CUnicode, CBool, Any
from IPython.kernel.zmq.kernelapp import kernel_flags, kernel_aliases, IPKernelApp
from IPython.kernel.zmq.pylab.config import InlineBackend
from IPython.kernel.zmq.session import Session, default_secure
from IPython.kernel.zmq.zmqshell import ZMQInteractiveShell
from IPython.kernel.connect import ConnectionFileMixin
from IPython.utils.localinterfaces import localhost
flags = dict(kernel_flags)
app_flags = {'existing': ({'SimpleClient': {'existing': 'kernel*.json'}}, 'Connect to an existing kernel. If no argument specified, guess most recent')}
app_flags.update(boolean_flag('confirm-exit', 'SimpleClient.confirm_exit', "Set to display confirmation dialog on exit. You can always use 'exit' or 'quit',\n       to force a direct exit without any confirmation.\n    ", "Don't prompt the user when exiting. This will terminate the kernel\n       if it is owned by the frontend, and leave it alive if it is external.\n    "))
flags.update(app_flags)
aliases = dict(kernel_aliases)
app_aliases = dict(ip='SimpleClient.ip', transport='SimpleClient.transport', hb='SimpleClient.hb_port', shell='SimpleClient.shell_port', iopub='SimpleClient.iopub_port', stdin='SimpleClient.stdin_port', existing='SimpleClient.existing', f='SimpleClient.connection_file', kernel='SimpleClient.kernel_name', ssh='SimpleClient.sshserver')
aliases.update(app_aliases)
classes = [KernelManager, ProfileDir, Session]

class SimpleClient(ConnectionFileMixin):
    name = 'ipython-console-mixin'
    description = '\n    '
    classes = classes
    flags = Dict(flags)
    aliases = Dict(aliases)
    kernel_manager_class = KernelManager
    kernel_client_class = BlockingKernelClient
    kernel_argv = List(Unicode)
    frontend_flags = Any(app_flags)
    frontend_aliases = Any(app_aliases)
    auto_create = CBool(True)
    sshserver = Unicode('', config=True, help='The SSH server to use to connect to the kernel.')
    sshkey = Unicode('', config=True, help='Path to the ssh key to use for logging in to the ssh server.')

    def _connection_file_default(self):
        return 'kernel-%i.json' % os.getpid()

    existing = CUnicode('', config=True, help='Connect to an already running kernel')
    kernel_name = Unicode('python', config=True, help='The name of the default kernel to start.')
    confirm_exit = CBool(True, config=True, help="\n        Set to display confirmation dialog on exit. You can always use 'exit' or 'quit',\n        to force a direct exit without any confirmation.")

    @property
    def help_classes(self):
        """ConsoleApps can configure kernels on the command-line
        
        But this shouldn't be written to a file
        """
        return self.classes + [IPKernelApp] + IPKernelApp.classes

    def build_kernel_argv(self, argv = None):
        """build argv to be passed to kernel subprocess"""
        if argv is None:
            argv = sys.argv[1:]
        self.kernel_argv = swallow_argv(argv, self.frontend_aliases, self.frontend_flags)

    def init_connection_file(self):
        """find the connection file, and load the info if found.
        
        The current working directory and the current profile's security
        directory will be searched for the file if it is not given by
        absolute path.
        
        When attempting to connect to an existing kernel and the `--existing`
        argument does not match an existing file, it will be interpreted as a
        fileglob, and the matching file in the current profile's security dir
        with the latest access time will be used.
        
        After this method is called, self.connection_file contains the *full path*
        to the connection file, never just its name.
        """
        if self.existing:
            try:
                cf = find_connection_file(self.existing)
            except Exception:
                self.log.critical('Could not find existing kernel connection file %s', self.existing)
                self.exit(1)

            self.log.debug('Connecting to existing kernel: %s' % cf)
            self.connection_file = cf
        else:
            try:
                cf = find_connection_file(self.connection_file)
            except Exception:
                if self.connection_file == os.path.basename(self.connection_file):
                    cf = os.path.join(self.profile_dir.security_dir, self.connection_file)
                else:
                    cf = self.connection_file
                self.connection_file = cf

        try:
            self.connection_file = filefind(self.connection_file, ['.', self.profile_dir.security_dir])
        except IOError:
            self.log.debug('Connection File not found: %s', self.connection_file)
            return

        try:
            self.load_connection_file()
        except Exception:
            self.log.error('Failed to load connection file: %r', self.connection_file, exc_info=True)
            self.exit(1)

    def init_ssh(self):
        """set up ssh tunnels, if needed."""
        if not self.existing or not self.sshserver and not self.sshkey:
            return
        self.load_connection_file()
        transport = self.transport
        ip = self.ip
        if transport != 'tcp':
            self.log.error('Can only use ssh tunnels with TCP sockets, not %s', transport)
            sys.exit(-1)
        if self.sshkey and not self.sshserver:
            self.sshserver = ip
            ip = localhost()
        info = dict(ip=ip, shell_port=self.shell_port, iopub_port=self.iopub_port, stdin_port=self.stdin_port, hb_port=self.hb_port)
        self.log.info('Forwarding connections to %s via %s' % (ip, self.sshserver))
        self.ip = localhost()
        try:
            newports = tunnel_to_kernel(info, self.sshserver, self.sshkey)
        except:
            self.log.error('Could not setup tunnels', exc_info=True)
            self.exit(1)

        self.shell_port, self.iopub_port, self.stdin_port, self.hb_port = newports
        cf = self.connection_file
        base, ext = os.path.splitext(cf)
        base = os.path.basename(base)
        self.connection_file = os.path.basename(base) + '-ssh' + ext
        self.log.info('To connect another client via this tunnel, use:')
        self.log.info('--existing %s' % self.connection_file)

    def _new_connection_file(self):
        cf = ''
        while not cf:
            ident = str(uuid.uuid4()).split('-')[-1]
            cf = os.path.join(self.profile_dir.security_dir, 'kernel-%s.json' % ident)
            cf = cf if not os.path.exists(cf) else ''

        return cf

    def init_kernel_manager(self):
        if self.existing:
            self.kernel_manager = None
            return
        signal.signal(signal.SIGINT, signal.SIG_DFL)
        try:
            self.kernel_manager = self.kernel_manager_class(ip=self.ip, session=self.session, transport=self.transport, shell_port=self.shell_port, iopub_port=self.iopub_port, stdin_port=self.stdin_port, hb_port=self.hb_port, connection_file=self.connection_file, kernel_name=self.kernel_name, parent=self, ipython_dir=self.ipython_dir)
        except NoSuchKernel:
            self.log.critical('Could not find kernel %s', self.kernel_name)
            self.exit(1)

        self.kernel_manager.client_factory = self.kernel_client_class
        self.kernel_manager.start_kernel(extra_arguments=self.kernel_argv)
        atexit.register(self.kernel_manager.cleanup_ipc_files)
        if self.sshserver:
            self.kernel_manager.write_connection_file()
        km = self.kernel_manager
        self.shell_port = km.shell_port
        self.iopub_port = km.iopub_port
        self.stdin_port = km.stdin_port
        self.hb_port = km.hb_port
        self.connection_file = km.connection_file
        atexit.register(self.kernel_manager.cleanup_connection_file)

    def init_kernel_client(self):
        if self.kernel_manager is not None:
            self.kernel_client = self.kernel_manager.client()
        else:
            self.kernel_client = self.kernel_client_class(session=self.session, ip=self.ip, transport=self.transport, shell_port=self.shell_port, iopub_port=self.iopub_port, stdin_port=self.stdin_port, hb_port=self.hb_port, connection_file=self.connection_file, parent=self)
        self.kernel_client.start_channels()

    def initialize(self, argv = None):
        self.init_connection_file()
        default_secure(self.config)
        self.init_ssh()
        self.init_kernel_manager()
        self.init_kernel_client()


try:
    get_ipython
except NameError:

    class NoOp(object):

        def __call__(self, *a, **kw):
            pass

        def __getattribute__(self, key):
            return lambda *args: '0'


    get_ipython = NoOp()
