#!/bin/bash

set -ue
unalias -a

if ! vim --version | grep '\+clientserver' -q ; then
    >2& echo "Your vim does not have +clientserver. Fix that."
    exit 1
fi

if ! which git > /dev/null 2>&1 ; then
    >2& echo "You need 'git'. Install that."
    exit 1
fi

if [ ! ~/virtualenv ] ; then
    >2& echo "Create a ~/virtualenv first."
    exit 1
fi

DOT_REPO=git/stnbu/dot
DOTS='
    bin
    .config
    .git
    .gitconfig
    .gitignore
    .inputrc
    .ipython
    .osx
    .python
    .pythonrc.py
    .tmux.conf
    .vim
    .vimrc
'
DOT_BACKUP=~/.dot_backup.$(date +%s)

cd ~/

for DOT in $DOTS ; do
    if [ ! -r "$DOT_REPO/$DOT" ] ; then
        >2& echo "$DOT_REPO/$DOT does not exist. Aborting."
        exit 1
    fi
done

mkdir -p $DOT_BACKUP
for DOT in $DOTS ; do
    if [ -r $DOT ] ; then
        mv -v $DOT $DOT_BACKUP/
    fi
    ln -s "$DOT_REPO/$DOT" ./
done

if [ -r ~/.bashrc ] ; then
    mv -v ~/.bashrc $DOT_BACKUP/
fi

cd ~/

BASHRC_GENERIC=`readlink -f $DOT_REPO/.bashrc.generic`
echo "Creating default ~/.bashrc. Edit to taste."
cat > ~/.bashrc << EOF
export VIRTUAL_ENV_DISABLE_PROMPT=true
. ~/virtualenv/bin/activate
. $BASHRC_GENERIC
EOF

set +ue
. ~/.bashrc
set -ue
unalias -a

if [ ! -L ~/.vim ] ; then
    >2& echo "You don't have a ~/.vim dir. How? Aborting."
    exit 1
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
    mkdir -p ~/.vim/bundle
    cd ~/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git
fi

cd ~/
if ! vim --servername VIM +PluginInstall +qall ; then
    >2& echo "Bundle installs failed."
    exit 1
fi

if [ ! -d ~/.vim/bundle/YouCompleteMe ] ; then
    >2& echo "~/.vim/bundle/YouCompleteMe does not exist. Aborting."
    exit 1
fi

cd ~/.vim/bundle/YouCompleteMe
if ! ./install.sh ; then
    >2& echo "~/.vim/bundle/YouCompleteMe/install.sh failed. Maybe try..."
    >2& echo " 'apt-get install python-dev' or 'brew install python'"
    exit 1
fi
