
c = get_config()
c.InteractiveShell.cache_size = 0
c.PlainTextFormatter.pprint = False
c.PromptManager.in_template = '>>> '
c.PromptManager.in2_template = '... '
c.PromptManager.out_template = ''
c.TerminalInteractiveShell.banner1 = u''
c.TerminalInteractiveShell.banner2 = u''
c.TerminalInteractiveShell.display_banner = False

c.InteractiveShell.separate_in = ''
c.InteractiveShell.separate_out = ''
c.InteractiveShell.separate_out2 = ''
#c.InteractiveShell.colors = 'NoColor'
#c.InteractiveShell.xmode = 'Plain'
c.InteractiveShell.confirm_exit = False
#c.InteractiveShellApp.extensions = [
#    'duster',
#]
c.IPythonTerminalApp.display_banner = False
c.HistoryManager.db_log_output = True
