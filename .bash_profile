#
# ~/.bash_profile
#

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control
shopt -s checkwinsize

# Disable completion when the input buffer is empty
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Save multi-line commands as one command
shopt -s cmdhist

# Shell only exists after the 10th consecutive Ctrl-d. Same as IGNOREEOF=10
set -o ignoreeof

for sh in /etc/bash/bashrc.d/* ; do
    [[ -r ${sh} ]] && source "${sh}"
done

# Start SSH agent
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Faster git
alias boum='git co master && git pull origin master'

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# Find symlinks in current dir
alias findsymlinks="find . -type d \! -name . -prune -o -type l -print | sort"

# Color ls
alias ls="ls --color=auto"
alias l="ls -lF --color=auto"
alias la="ls -laF --color=auto"
alias lsd='ls -lF --color=auto | grep "^d"'

if type -P dircolors >/dev/null ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    LS_COLORS=
    if [[ -f ~/.dir_colors ]] ; then
        # If you have a custom file, chances are high that it's not the default.
        used_default_dircolors="no"
        eval "$(dircolors -b ~/.dir_colors)"
    elif [[ -f /etc/DIR_COLORS ]] ; then
        # People might have customized the system database.
        used_default_dircolors="maybe"
        eval "$(dircolors -b /etc/DIR_COLORS)"
    else
        used_default_dircolors="yes"
        eval "$(dircolors -b)"
    fi
    if [[ -n ${LS_COLORS:+set} ]] ; then
        use_color=true
    fi
    unset used_default_dircolors
fi

# Color grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Color man pages
man() {
    env \
      LESS_TERMCAP_mb=$(printf "\e[1;31m") \
      LESS_TERMCAP_md=$(printf "\e[1;31m") \
      LESS_TERMCAP_me=$(printf "\e[0m") \
      LESS_TERMCAP_se=$(printf "\e[0m") \
      LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
      LESS_TERMCAP_ue=$(printf "\e[0m") \
      LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# PS color
BLACK="\033[01;30m"
MAGENTA="\033[1;31m"
ORANGE="\033[1;33m"
GREEN="\033[1;32m"
PURPLE="\033[1;35m"
WHITE="\033[1;37m"
BOLD=""
RESET="\033[m"

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Show host if connected through ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    if [ "$color_prompt" = yes ]; then
        host="\u@\[\033[1;34m\]\h\[\033[00m\]"
    else
        host="\u@\h"
    fi
fi

# Sweeeeeet symbol.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="\[$ORANGE\]❯\[$RESET\] "

prompt_user="\[${BOLD}${GREEN}\]\u$host"
prompt_cwd="\[$WHITE\]in \[$ORANGE\]\w"
prompt_git="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)"
prompt_symbol="\[$WHITE\]\n$symbol"

export PS1="$prompt_user $prompt_cwd\[$WHITE\]$prompt_git$prompt_symbol\[$RESET\]"
export PS2="\[$PURPLE\]→ \[$RESET\]"

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# Add local binaries to path
export PATH=$PATH:~/.local/bin

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

# Better history
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Default apps
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export BROWSER="chromium"
export GNUPGHOME="~/.gnupg"

# Load Hub
[ -x "$(command -v hub)" ] && eval "$(hub alias -s)"

# Import z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# Import nvm
[[ -r "/usr/share/nvm/init-nvm.sh" ]] && source /usr/share/nvm/init-nvm.sh

# Try to enable the auto-completion
[ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion

# Import any additional secrets
[ -r ~/.secrets ] && source ~/.secrets

# Import fzf
[ -r "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash
[ -r "/usr/share/fzf/completion.bash" ] && source /usr/share/fzf/completion.bash

# Safety first
source ~/.bashrc
