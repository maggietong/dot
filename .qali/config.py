import os

PFAST = 0
THREAD = 1
STANDARD = 2
PDBG = 3
STANDARDDBG = 4

mode = PFAST
#mode = PDBG
#mode = THREAD
#mode = STANDARD
#mode = STANDARDDBG
#log_level = 'DEBUG'
log_level = 'ERROR'

ucs.spy = False
#iom.preferred_transport = CONSOLE_TRANSPORT
iom.preferred_transport = complex()
ucs.identifier = 'bb17.spam48'
ucs.spyfile = sys.stderr
os.environ['QALI_CLUSTER'] = ucs.identifier

if mode == THREAD:
    qali_global.use_paramiko = True
    qali_global.threading = True
    qali_global.log_paramiko_io = False
elif mode == PFAST:
    qali_global.use_paramiko = True
    qali_global.log_paramiko_io = False
    qali_global.threading = False
elif mode == PDBG:
    qali_global.use_paramiko = True
    qali_global.log_paramiko_io = True
    qali_global.threading = False
elif mode == STANDARD:
    qali_global.use_paramiko = False
    qali_global.threading = False
    qali_global.log_paramiko_io = False
elif mode == STANDARDDBG:
    qali_global.use_paramiko = False
    qali_global.threading = False
    qali_global.log_paramiko_io = False


if qali_global.threading:
    from qali.thread.main import fake_logging
    fake_logging.min_repeat_interval = 0
    fake_logging.no_repeats = False
    fake_logging.level = log_level
else:
    import logging
    console = logging.StreamHandler()
    logger = logging.getLogger()
    logger.setLevel(log_level)
    logger.addHandler(console)

#glados.output_root = '/tmp/xig'

try:
    mike = ConfigSpace('mike')
except NameError:
    mike = NameSpace('mike')
mike.raise_debugger = True
