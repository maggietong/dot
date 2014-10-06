import os
import sys
import getpass
import copy

GLOBAL_DEBUG = bool(os.getenv('IPYTHON_GLOBAL_DEBUG', False))
DEBUG_LEVEL = GLOBAL_DEBUG and u'DEBUG' or u'INFO'
HOMEDIR = os.path.expanduser('~/')
IPY_PROFILEDIR = os.path.join(HOMEDIR, '.ipython', 'profile_default')
LOCALHOST = '127.0.0.1'
CONTROL_PORT = 53513
SHELL_PORT = 83403
HB_PORT = 62420
IOPUB_PORT = 89621
STDIN_PORT = 47881
HTTP_PORT = 8888
IP_TRANSPORT = 'tcp'
KERNEL_NAME='skeeter'

LOG_DIR = os.path.join(IPY_PROFILEDIR, 'log')

VARIOUS_DEBUG = GLOBAL_DEBUG

c = get_config()


#c.BaseIPythonApplication.extra_config_file =
#c.BaseIPythonApplication.ipython_dir =
#c.IPKernelApp.connection_file =
#c.IPKernelApp.interrupt =
#c.IPKernelApp.parent_handle =
#c.IPythonConsoleApp.connection_file =
#c.IPythonConsoleApp.connection_file =
#c.IPythonConsoleApp.existing =
#c.IPythonConsoleApp.gui = 'osx'
c.IPythonConsoleApp.nosep = True
#c.IPythonConsoleApp.sshserver =
c.InteractiveShell.autocall = False
c.InteractiveShellApp.module_to_run = 'startup'
#c.NotebookApp.aliases =
#c.NotebookApp.allow_credentials =
#c.NotebookApp.allow_origin =
#c.NotebookApp.auto_create =
#c.NotebookApp.browser =
#c.NotebookApp.classes =
#c.NotebookApp.default_url =
#c.NotebookApp.enable_mathjax =
#c.NotebookApp.examples =
#c.NotebookApp.file_to_run =
#c.NotebookApp.flags =
#c.NotebookApp.jinja_environment_options =
#c.NotebookApp.kernel_argv =
#c.NotebookApp.notebook_dir =
#c.NotebookApp.password =
#c.NotebookApp.subcommands =
#c.NotebookApp.tornado_settings =
#c.NotebookApp.webapp_settings =

c.Application.log_level = DEBUG_LEVEL
c.FileNotebookManager.notebook_dir = IPY_PROFILEDIR
c.FileNotebookManager.save_script = True
c.IPControllerApp.location = LOCALHOST
c.IPControllerApp.restore_engines = True
c.IPControllerApp.reuse_file = True
c.IPControllerApp.use_threds = True
c.IPKernelApp.auto_create = False
c.IPKernelApp.connection_file = 'kernel-default.json'
#c.IPKernelApp.control_port = CONTROL_PORT
#c.IPKernelApp.control_port = CONTROL_PORT
c.IPKernelApp.gui = 'osx'
#c.IPKernelApp.hb_port = HB_PORT
#c.IPKernelApp.hb_port = HB_PORT
#c.IPKernelApp.iopub_port = IOPUB_PORT + 20
c.IPKernelApp.ip = LOCALHOST
c.IPKernelApp.ip = LOCALHOST
#c.IPKernelApp.name = KERNEL_NAME
#c.IPKernelApp.kernel_name = KERNEL_NAME
c.IPKernelApp.log_datefmt = '%Y-%m-%d %H:%M:%S'
c.IPKernelApp.log_format = '[%(name)s] %(message)s'
c.IPKernelApp.log_level = DEBUG_LEVEL
c.IPKernelApp.no_stdout = False
c.IPKernelApp.overwrite = False
#c.IPKernelApp.shell_port = SHELL_PORT + 20
#c.IPKernelApp.stdin_port = STDIN_PORT + 20
c.IPKernelApp.transport = IP_TRANSPORT
c.IPKernelApp.verbose_crash = VARIOUS_DEBUG
c.IPythonConsoleApp.confirm_exit = False
#c.IPythonConsoleApp.hb_port=HB_PORT
#c.IPythonConsoleApp.iopub_port=IOPUB_PORT + 30
c.IPythonConsoleApp.ip = LOCALHOST
#c.IPythonConsoleApp.kernel_name = KERNEL_NAME
#c.IPythonConsoleApp.shell_port = SHELL_PORT + 30
#c.IPythonConsoleApp.stdin_port = STDIN_PORT + 30
c.IPythonConsoleApp.transport = IP_TRANSPORT
c.IPythonConsoleApp.transport=IP_TRANSPORT
c.KernelManager.ip = LOCALHOST
c.MappingKernelManager.root_dir = IPY_PROFILEDIR
c.NotebookApp.cert = b''
c.NotebookApp.certfile = u''
c.NotebookApp.cookie_secret = b'mylilnn'
#c.NotebookApp.cookie_secret_file = u''
c.NotebookApp.description = ''
c.NotebookApp.ip = LOCALHOST
c.NotebookApp.port = HTTP_PORT
#c.NotebookApp.kernel_name = KERNEL_NAME
c.NotebookApp.key = b''
c.NotebookApp.keyfile = u''
c.NotebookApp.log_format = '[%(name)s] %(message)s'
c.NotebookApp.log_level = DEBUG_LEVEL
#c.NotebookApp.name = KERNEL_NAME
c.NotebookApp.notebook_dir = IPY_PROFILEDIR
c.NotebookApp.open_browser = False
c.NotebookApp.overwrite = False
c.NotebookApp.port_retries = 100
c.NotebookApp.verbose_crash = VARIOUS_DEBUG
c.Session.debug = VARIOUS_DEBUG
c.Session.username = getpass.getuser()
c.TerminalInteractiveShell.autoedit_syntax = False
c.TerminalInteractiveShell.classic = True
c.TerminalInteractiveShell.colors = 'LightBG'
#c.TerminalInteractiveShell.colors = 'Linux'
#c.TerminalInteractiveShell.colors = 'NoColor'
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.secure = False
c.TerminalTerminalInteractiveShell.autoindet = True
c.TerminalTerminalInteractiveShell.pprint = True
c.TerminalTerminalInteractiveShell.term_title = True
c.ZMQInteractiveShell.debug = VARIOUS_DEBUG
c.ZMQInteractiveShell.disable_failing_post_execute = False
c.ZMQInteractiveShell.history_length = sys.maxint
#c.TerminalInteractiveShell.editor = '/usr/local/bin/vim'
c.TerminalInteractiveShell.editor = '/usr/local/bin/gvim'
#c.ZMQInteractiveShell.logappend = 'appendmode.log'
messages = os.path.join(LOG_DIR, 'messages-{0}.log'.format(os.getpid()))
c.ZMQInteractiveShell.logfile = messages
c.ZMQInteractiveShell.logstart = False
c.ZMQInteractiveShell.pdb = False
c.ZMQInteractiveShell.pydb = False

#c.HistoryManager.db_cache_size =
c.HistoryManager.db_log_output = True
c.HistoryManager.enabled = True
#c.HistoryManager.hist_file = Unicode


