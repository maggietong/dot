"""

>>> os.readlink('/usr/local/bin/yes')
'../gnutools/yes'

"""

import os
import sys
from glob import glob
import subprocess

brew_prefix = subprocess.check_output(['brew', '--prefix']).strip()
brewbin = os.path.join(brew_prefix, 'bin')
gtools = os.path.join(brewbin, 'g*')
gnutools_links_dir = os.path.join(brewbin, '..', 'gnutools')
gnutools_links_dir = os.path.realpath(gnutools_links_dir)

if not os.path.exists(gnutools_links_dir):
    os.mkdir(gnutools_links_dir)

def make_gnutools_links():
    for tool in glob(gtools):
        for path in '/bin', '/usr/bin':
            realname = os.path.basename(tool)
            realname = realname[1:]
            if os.path.exists('{0}/{1}'.format(path, realname)):
                dst = os.path.join(gnutools_links_dir, realname)
                if not os.path.exists(dst):
                    src = os.path.join('..', 'bin', os.path.basename(tool))
                    os.symlink(src, dst)

def enable_all_gnutools_links():
    for tool in glob(os.path.join(gnutools_links_dir, '*')):
        src = os.path.join('..', 'gnutools', os.path.basename(tool))
        dst = os.path.join(brewbin, os.path.basename(tool))
        if not os.path.exists(dst):
            os.symlink(src, dst)

def delete_all_gunutools_links():
    for tool in glob(os.path.join(brewbin, '*')):
        if not os.path.islink(tool):
            continue
        link = os.readlink(tool)
        if os.path.dirname(link) == os.path.join('..', 'gnutools'):
            os.unlink(tool)


make_gnutools_links()
enable_all_gnutools_links()
#delete_all_gunutools_links()
