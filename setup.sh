#!/bin/sh

mkdir -p ~/junk
mv -f ~/virtualenv ~/junk/
mkdir -p ~/virtualenv
virtualenv ~/virtualenv/current
export VIRTUAL_ENV_DISABLE_PROMPT=true
. ~/virtualenv/current/bin/activate
sudo aptitude install exuberant-ctags
pip install GitPython
cd ~/.vim/bundle/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u ~/dot/setup.vimrc +BundleInstall +qall
vim +BundleInstall +qall
cd ~/.vim/bundle/YouCompleteMe/
./install.sh 
cd ~/
for f in .bash.d .bashrc .config .git .gitignore .inputrc .ipython .osx .purple .python .tmux.conf .vim .vimrc ; do mv -i $f ~/junk/; ln -s dot/$f ./; done
