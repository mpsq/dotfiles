# ~/.profile

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

# Color utils
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls="exa --color=auto"
alias l="exa -lF --color=auto"
alias la="exa -laF --color=auto"
alias lah="exa -lah --color=auto"
alias lsd='exa -lF --color=auto | grep "^d"'

eval $(keychain --eval --quiet --agents ssh,gpg id_rsa B78ABA26623D1326)

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

# PS color
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
        BLACK=$(tput setaf 190)
        MAGENTA=$(tput setaf 9)
        ORANGE=$(tput setaf 172)
        GREEN=$(tput setaf 190)
        PURPLE=$(tput setaf 141)
        WHITE=$(tput setaf 0)
    else
        BLACK=$(tput setaf 190)
        MAGENTA=$(tput setaf 5)
        ORANGE=$(tput setaf 4)
        GREEN=$(tput setaf 2)
        PURPLE=$(tput setaf 1)
        WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    BLACK="\033[01;30m"
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

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

symbol="$\[$RESET\] "

prompt_user="\[${BOLD}${GREEN}\]\u$host"
prompt_cwd="\[$WHITE\]\[$ORANGE\]\w"
prompt_git="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\[$PURPLE\]\$(parse_git_branch)"
prompt_symbol="\[$WHITE\]\n$symbol"

if test -z "$BASH_VERSION" || test -n "$BASH_VERSION" -a \( "${BASH##*/}" = "sh" \)
then
  export PS1="$prompt_user $prompt_cwd\[$RESET\]"
else
  export PS1="$prompt_user $prompt_cwd\[$WHITE\]$prompt_git$prompt_symbol\[$RESET\]"
  export PS2="\[$PURPLE\]→ \[$RESET\]"
fi

# Load Hub
[ -x "$(command -v hub)" ] && eval "$(hub alias -s)"

# Import z
[ -r "/usr/share/z/z.sh" ] && source /usr/share/z/z.sh

# Import nvm
[ -r "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh

# Try to enable the auto-completion
[ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion

# Import fzf
[ -r "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash
[ -r "/usr/share/fzf/completion.bash " ] && source /usr/share/fzf/completion.bash

# Import any additional secrets
[ -r ~/.secrets ] && source ~/.secrets
