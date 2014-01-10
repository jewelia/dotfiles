# Augment environment with user-local installs
export PYTHONPATH=$PYTHONPATH
export PATH=/usr/local/share/python:/usr/local/bin:$PATH 
export HISTSIZE=10000

export WORKON_HOME=~/envs
source /usr/local/bin/virtualenvwrapper.sh

# Colorize ls by default
 if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    export GREP_OPTIONS='--color=auto'
    export GREP_COLOR='0;32'
fi

# Colorize the prompt
if [ "$PS1" ]; then
    host_format="\[\033[01;32m\]"
    user_format="\[\033[01;32m\]"
    path_format="\[\033[01;34m\]"
    input_format="\[\033[00m\]"

    if [ "$SSH_CONNECTION" ]; then
        host_format="\[\033[01;36m\]"
    fi

    case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$H
OME/~}"; echo -ne "\033\\"'
        path_format="\[\033[00;33m\]"
        ;;
    esac

    if [[ ${EUID} == 0 ]] ; then
            PS1="${host_format}\h\${path_format} \W \$${input_format} "
    else
            PS1="${user_format}\u${host_format}@\h${path_format} \w \$${input_format} "
    fi

    shopt -s checkwinsize
fi

# Download from https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
source ~/projects/git-scripts/git-completion.bash
# Download from https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
source ~/projects/git-scripts/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM="auto"
LIGHTNING_BOLT=$'\xE2\x9A\xA1'
PROMPT_COMMAND='__git_ps1 "\W" "$LIGHTNING_BOLT "'
