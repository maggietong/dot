
if [ -f ~/.current_tree ] ; then
    #source `cat ~/.current_tree`/qali/config/qa_bashrc
    true
fi


# wget -O - -q http://http.us.debian.org/debian/pool/main/b/bash-completion/bash-completion_2.0-1_all.deb
# ar x /tmp/f.deb

export MYUCS=bb17-spam48
export CURRENT_TREE=~/git/mainline
export PYTHONPATH=$CURRENT_TREE:$CURRENT_TREE/qali/extern:~/.python/site

alias xcopy=pbcopy

alias switchqa='ssh -l switchqa savbu-plt-utl4'

export VIRTUAL_ENV_DISABLE_PROMPT='yes, please'

alias pager=less

if which brew > /dev/null 2>&1 ; then
    if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
        . $(brew --prefix)/share/bash-completion/bash_completion
    fi
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ] ; then
    # FIXME: Why is it not enough just to put this in bash_compl.d ?
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi


alias bb17-spam48='javaws http://10.193.197.2/ucsm/ucsm.jnlp'
alias bb17-mam48='javaws http://10.193.197.4/ucsm/ucsm.jnlp'

HISTFILESIZE=99999

export PATH=~/bin:$PATH:$CURRENT_TREE/qali/bin

alias pep8='pep8 --max-line-length=119'

if [ -e ~/virtualenv/current ] ; then
    . ~/virtualenv/current/bin/activate
else
    echo "No virtualenv!!" >&2
fi

if [ -e ~/.bash.d/git-completion.bash ] ; then
    . ~/.bash.d/git-completion.bash
else
    echo "No git bash completion!!" >&2
fi

if [ -e ~/.bash.d/pip-completion.bash ] ; then
    . ~/.bash.d/pip-completion.bash
else
    echo "No pip bash completion!!" >&2
fi

if [ -e ~/git/mainline ] ; then
    cd ~/git/mainline
else
    echo "No git repo!!" >&2
fi

alias editor=vim
alias pager=less


