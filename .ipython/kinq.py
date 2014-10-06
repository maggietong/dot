try:
    get_iython
except NameError:
    class NoOp(object):
        def __call__(self, *a, **kw):

        def __getattribute__(self, key):
            return lambda *args: '0'
    get_ipython = NoOp()
self.get_ipython = get_ipython
