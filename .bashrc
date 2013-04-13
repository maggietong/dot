export MYUCS=bb17-spam48
export CURRENT_TREE=~/git/mainline

#export QATOOLS="${QATOOLS-/net/savbu-plt-utl4/qali/tools/redhat_61}"
#export QTDIR="${QATOOLS}/QtSDK/Desktop/Qt/4.8.0/gcc"
export PYTHONPATH=$CURRENT_TREE:$CURRENT_TREE/qali/extern:~/.python/site
#export PATH=/usr/local/bin:$PATH
#export PATH="$PYTHONPATH:$QATOOLS/bin:$PATH"
#export PATH=~/bin:/usr/local/share/python:$PATH
export PATH=~/bin:/usr/local/share/python:$PATH:$CURRENT_TREE/qali/bin
#export LD_LIBRARY_PATH="${QATOOLS}/lib:/usr/lib64/:/usr/lib:/lib"
#export MANPATH="${QATOOLS}/share/man:${QATOOLS}/man:/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/X11R6/man"

alias xcopy=pbcopy

alias switchqa='ssh -l switchqa savbu-plt-utl4'

#export TERM=screen-256color

export VIRTUAL_ENV_DISABLE_PROMPT='yes, please'

PATH=/usr/local/Cellar/python/2.7.3/Frameworks/Python.framework/Versions/2.7/bin:$PATH

alias pager=less

if [ -e ~/virtualenv/27 ] ; then
    . ~/virtualenv/27/bin/activate
fi
