import signal
import atexit
from IPython.kernel.kernelspec import NoSuchKernel
from IPython.config.loader import Config

def _init_kernel_manager(self):
    # Don't let Qt or ZMQ swallow KeyboardInterupts.
    if self.existing:
        self.kernel_manager = None
        return
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    # Create a KernelManager and start a kernel.
    try:
        kwargs = dict( ip=self.ip, session=self.session,
                     transport=self.transport, shell_port=self.shell_port,
                     iopub_port=self.iopub_port, stdin_port=self.stdin_port,
                     hb_port=self.hb_port, connection_file=self.connection_file,
                     kernel_name=self.kernel_name, parent=self,
                     ipython_dir=self.ipython_dir,)


        self.kernel_manager = self.kernel_manager_class()
        conf = Config(**kwargs)
        self.kernel_manager.config = Config(**conf)
    except NoSuchKernel:
        self.log.critical("Could not find kernel %s", self.kernel_name)
        self.exit(1)

    self.kernel_manager.client_factory = self.kernel_client_class
    self.kernel_manager.start_kernel(extra_arguments=self.kernel_argv)
    atexit.register(self.kernel_manager.cleanup_ipc_files)

    if self.sshserver:
        # ssh, write new connection file
        self.kernel_manager.write_connection_file()

    # in case KM defaults / ssh writing changes things:
    km = self.kernel_manager
    self.shell_port=km.shell_port
    self.iopub_port=km.iopub_port
    self.stdin_port=km.stdin_port
    self.hb_port=km.hb_port
    self.connection_file = km.connection_file

    atexit.register(self.kernel_manager.cleanup_connection_file)
