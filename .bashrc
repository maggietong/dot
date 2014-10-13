
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

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

if [ -d ~/bin ] ; then
    PATH=~/bin:"$PATH"
fi

# Never, ever lose any history!
export HISTCONTROL=ignoredups:erasedups
## http://superuser.com/questions/479726/how-to-get-infinite-command-history-in-bash
export HISTSIZE="nnnnnn..."
export HISTFILESIZE="nnnnnn..."
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
alias editor=vim


export EDITOR=editor

