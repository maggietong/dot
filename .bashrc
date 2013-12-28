
if [ -f ~/.current_tree ] ; then
    #source `cat ~/.current_tree`/qali/config/qa_bashrc
    true
fi


# wget -O - -q http://http.us.debian.org/debian/pool/main/b/bash-completion/bash-completion_2.0-1_all.deb
# ar x /tmp/f.deb

export MYUCS=bb17-spam48
export CURRENT_TREE=~/git/mainline
export PYTHONUSERBASE=~/.python

export PYTHONPATH=""

if [ ! -z "${CURRENT_TREE}" -a -e "${CURRENT_TREE}" ] ;then
    export PYTHONPATH=$CURRENT_TREE:$CURRENT_TREE/qali/extern:$PYTHONPATH
fi

if [ ! -z "${PYTHONUSERBASE}" -a -e "${PYTHONUSERBASE}" ] ;then
    export PYTHONPATH=$PYTHONPATH:$PYTHONUSERBASE
fi

export PYTHONSTARTUP=$PYTHONUSERBASE/startup.py

export VIRTUAL_ENV_DISABLE_PROMPT=true

if which brew > /dev/null 2>&1 ; then
    if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
        . $(brew --prefix)/share/bash-completion/bash_completion
    fi
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ] ; then
    # https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
    # FIXME: Why is it not enough just to put this in bash_compl.d ?
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

HISTFILESIZE=99999

if [ -e ~/virtualenv/current ] ; then
    . ~/virtualenv/current/bin/activate
    F=$(python -c "import sys; print '{}/lib/python{}.{}/no-global-site-packages.txt'.format(sys.prefix, sys.version_info.major, sys.version_info.minor)")
    if [ -e "$F" ] ; then
        echo "" >&2
        echo "  This file: $F" >&2
        echo "  ...may prevent you from using a usercustomsite.py" >&2
        echo "  You might consider getting rid of it. See 'site.py' for details." >&2
        echo "" >&2
    fi
fi

if [ -d ~/.bash.d ] ; then
    for f in ~/.bash.d/*.bash ; do
        . $f
    done
fi

if [ -e ~/git/mainline ] ; then
    cd ~/git/mainline
fi

alias printbash='enscript -2Gr -M Letter --color -DDuplex:true --pretty-print=bash'
alias printc='enscript -2Gr -M Letter --color -DDuplex:true --pretty-print=c'
alias printpy='enscript -2Gr -M Letter --color -DDuplex:true --pretty-print=python'
alias printpython='enscript -G -M Letter --color -DDuplex:true --pretty-print=python'
alias printtcl='enscript -2Gr -M Letter --color -DDuplex:true --pretty-print=tcl'
alias tabloidpy='enscript -G -M Tabloid --color -DDuplex:true --pretty-print=python'
alias tabloidsh='enscript -G -M Tabloid --color -DDuplex:true --pretty-print=sh'
alias xcopy=pbcopy

if [ -d ~/bin ] ; then
    PATH=~/bin:"$PATH"
fi
