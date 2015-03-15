
PATH="/bin:/usr/bin:/usr/sbin:/sbin"

if [ `uname` == "Darwin" ] ; then
    for P in "/usr/local/sbin" "/usr/local/bin" ; do
        if [ -d "${P}" ] ; then
            PATH="${P}:${PATH}"
        fi
    done
fi

export VIRTUAL_ENV_DISABLE_PROMPT=true

#export DISTUTILS_DEBUG=true

if which brew > /dev/null 2>&1 ; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
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

export EDITOR="vim --servername VIM"

alias vim="vim --servername VIM"
alias editor="vim --servername VIM"
alias pager=less

if [ -e ~/.bashrc.local ] ; then
    . ~/.bashrc.local
fi
