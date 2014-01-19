import git
repo = git.Repo('/Users/miburr/git/mainline')
repo.head
repo.index.repo.is_dirty()
repo.index.entries
repo.index.repo.git??
repo.index.repo.git.status
repo.index.repo.git.status()
repo.index.repo.remotes
repo.index.repo.remote
repo.index.repo.remote()
r = repo.index.repo.remote()
r.name
repo.index.version
repo.index.version??
repo.index.version.path
repo.index.path
repo.index.diff
repo.index.diff()
repo.remote
repo.remotes
repo.head.reference
repo.head.name
repo.head.reference.name
repo.head.heedra
repo.heads
repo.heads
[b.name for b in repo.heads]
repo.config_reader
c = repo.config_reader()
c
c.items
c.items()
c.get
c.get()
c.sections
c.sections()
c.items('user')
c.items.user
for name, value in c.items('user'):
    print name, '=', value
