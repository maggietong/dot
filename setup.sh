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
#pip install GitPython
#cd ~/source
#hg clone https://vim.googlecode.com/hg/ vim
#sudo yum groupsinstall 'Development Tools'
#sudo yum groupinstall 'Development Tools'
#sudo yum install perl-devel python-devel ruby-devel
#sudo yum install perl-ExtUtils-Embed ncurses-devel
#export PATH=/net/savbu-plt-utl4/qali/tools/redhat_61/bin:$PATH
#unset PYTHONSTARTUP
#unset PYTHONUSERBASE PYTHONPATH
#
#./configure --prefix=/ws/miburr-sjc/tools --enable-pythoninterp=yes --with-python-config-dir=/net/savbu-plt-utl4/qali/tools/redhat_61/lib/python2.7/config --enable-perlinterp --enable-gui=no --enable-cscope > /tmp/gd 2>&1
#make VIMRUNTIMEDIR=/ws/miburr-sjc/tools/share/vim/vim74
#make install
#
#wget 'http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz'
#tar -xf cmake-2.8.12.1.tar.gz 
#cd cmake-2.8.12.1
#
#./configure --prefix=/ws/miburr-sjc/tools
#gmake 
#make install
