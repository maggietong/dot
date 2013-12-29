
import os
import git
import vim

def find_repo_root(path):
    if not os.path.exists(path):
        return None
    while True:
        if os.path.isdir(os.path.join(path, '.git')):
            return path
        if path == os.path.sep:
            return None
        path = os.path.dirname(path)

def add_to_out(output, string):
    try:
        string, = string.splitlines()
        output.append(string)
    except ValueError:
        strings = string.splitlines()
        output.extend(strings)


def get_repo_report(path):

    output = []
    if path is None:
        return
    repo_path = find_repo_root(path)
    if repo_path is None:
        return
    repo = git.Repo(repo_path)
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

def write_to_vim_buffer(output):
    vim.current.buffer.append(output, 0)

def repo_report(path):
    output = get_repo_report(path)
    write_to_vim_buffer(output)
