
import os
import git
import vim
from glob import glob


def log(msg):
    return
    print msg

REPOS = {}

def get_user_input(prompt):
    vim.command("""
        call inputsave()
        let s:response = input('{prompt}')
        call inputrestore()
    """.format(prompt=prompt))
    return vim.eval('s:response')

#  vim.command("""
#              com FBar python vim_git.get_user_input("bigggg:  ")
#              """)

def get_repo(path):
    path = os.path.abspath(path)
    orig_path = path
    if not os.path.exists(path):
        log('path {} does not exist'.format(path))
    while True:
        log('trying {}...'.format(path))
        if os.path.isdir(os.path.join(path, '.git')):
            log('{} IS a git repo'.format(path))
            root = path
            break
        else:
            log('{} IS NOT a git repo'.format(path))
        if path == os.path.sep:
            log('unable to find git repo, starting at {}'.format(path))
            return None
        path = os.path.dirname(path)

    root = os.path.abspath(root).strip()
    if root not in REPOS:
        REPOS[root] = git.Repo(root)

    return REPOS[root]


def add_to_out(output, string):
    try:
        string, = string.splitlines()
        output.append(string)
    except ValueError:
        strings = string.splitlines()
        output.extend(strings)

def get_status(path):
    repo = get_repo(path)
    if repo is None:
        return '<No Repo Found>'
    return repo.git.status()

def add(paths):
    if isinstance(paths, str):
        paths = glob(paths)
    log('function add recieved paths={}'.format(paths))
    found_repos = []
    for path in paths:
        found_repos.append(get_repo(path))
    if len(set(found_repos)) != 1:
        log('not all files belong to the same repo')
        return ''
    repo, = set(found_repos)
    try:
        log('about to add file(s) {} to repo {}'.format(paths, repo))
        repo.index.add(paths)
        log('added file(s) {} to repo {}'.format(paths, repo))
    except OSError:
        raise

def commit():
    path = get_user_input('your path: ')
    repo = get_repo(path)
    if repo is None:
        return ''
    message = get_user_input('your message: ')
    commit = repo.index.commit(message)
    return commit

vim.command('com Commmmmit python vim_git.commit()\n')

def register_vim_function(pyfun):
    name = pyfun.func_name
    vim.command("""\
    fun! VimGit_{name}(glob)
        pclose
        exe "botright 8new _func_{name}_"
        setlocal buftype=nofile bufhidden=delete noswapfile nowrap previewwindow
        redraw
        python vim_git.{name}(vim.eval("a:glob"))
        setlocal nomodifiable
        setlocal nomodified
        setlocal filetype=rst
        wincmd p
    endfunction
    """.format(name=name))

register_vim_function(add)



def remove(path):
    repo.index.remove(path)

#### repo = Repo('/tmp/gg/mainline')
#### repo.index.add('.vim/plugin/bob.vim')
#### repo.index.add('.vim/plugin/bob.vim')
#### repo.index.remove(items='pip_list-l.out')
#### print repo.index.diff(None)
#### cc = repo.index.commit('wwooohoh')
####
####
####
#### test_remote = repo.create_remote('test', 'git@server:repo.git')
#### repo.delete_remote(test_remote) # create and delete remotes
#### origin = repo.remotes.origin    # get default remote by name
#### origin.refs                     # local remote references
#### o = origin.rename('new_origin') # rename remotes
#### o.fetch()                       # fetch, pull and push from and to the remote
#### o.pull()
#### o.push()


def get_repo_report(path):

    repo = get_repo(path)
    if repo is None:
        return ''
    output = []
    add_to_out(output, '=' * 100)
    add_to_out(output, 'branch: {}'.format(repo.active_branch.name))
    add_to_out(output, 'dirty: {}'.format(repo.is_dirty()))
    add_to_out(output, 'description: {}'.format(repo.description))
    add_to_out(output, 'untracked files: {}'.format(repo.untracked_files))
    add_to_out(output, 'git dir {}:'.format(repo.git_dir))
    add_to_out(output, 'last commit...')
    for attr in 'message', 'author', 'hexsha':
        add_to_out(output, '    {}: {}'.format(attr.capitalize(), getattr(repo.head.reference.commit, attr)))
    add_to_out(output, '=' * 100)
    return output


vim.command("""\
fun! VimGitShowReport()
    let l:file = expand('%:p')
    pclose
    exe "botright 8new _gitreport_"
    setlocal buftype=nofile bufhidden=delete noswapfile nowrap previewwindow
    redraw
    python vim_git.repo_report(vim.eval("l:file"))
    setlocal nomodifiable
    setlocal nomodified
    setlocal filetype=rst
    wincmd p
endfunction
""")

def write_to_vim_buffer(output):
    vim.current.buffer.append(output, 0)

def repo_report(path):
    output = get_repo_report(path)
    write_to_vim_buffer(output)

#
#
#  test_remote = repo.create_remote('test', 'git@server:repo.git')
#  repo.delete_remote(test_remote) # create and delete remotes
#  origin = repo.remotes.origin    # get default remote by name
#  origin.refs                     # local remote references
#  o = origin.rename('new_origin') # rename remotes
#  o.fetch()                       # fetch, pull and push from and to the remote
#  o.pull()
#  o.push()
#


#
#  o.url
#  'git@server:dummy_repo.git'
#
#  Change configuration for a specific remote only:
#
#  o.config_writer.set("pushurl", "other_url")
#

#
#  To switch between branches, you effectively need to point your HEAD to the new branch head and reset your index and working copy to match. A simple manual way to do it is the following one:
#
#  repo.head.reference = repo.heads.other_branch
#  repo.head.reset(index=True, working_tree=True)
#



