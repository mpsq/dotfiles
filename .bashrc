#!/usr/bin/env bash
# ~/.bashrc
# shellcheck disable=SC1091,SC1090

# Disable ctrl-s sending XOFF
stty ixany
stty ixoff -ixon

if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
        eval "$(dircolors -b ~/.dir_colors)"
    fi
fi

# Man pages
man() {
    env \
        LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;31m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[1;32m")" \
        man "$@"
}

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Enable history appending instead of overwriting when exiting
shopt -s histappend

# Autocorrect typos in path names when using cd
shopt -s cdspell

# Save multi-line commands as one command
shopt -s cmdhist

# Shell only exists after the 10th consecutive Ctrl-d. Same as IGNOREEOF=10
set -o ignoreeof

# Fancy PS1
if [[ $TERM = xterm-256color ]] ; then
    # Some Colours
    txtcyn='\e[0;36m' # Cyan
    txtprl='\e[1;35m' # Purple
    bldblu='\e[1;34m' # Bold Blue
    txtrst='\e[0m'    # Text Reset

    function parse_git_dirty() {
        [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
    }

    function parse_git_branch() {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
    }

    prompt_git="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \"\|)\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \|)"

    export PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtrst\]\[$txtprl\]$prompt_git\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"
fi

# Source things
[ -r "$HOME/.secrets" ] && . "$HOME/.secrets"
[ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion
[ -r "/usr/share/doc/pkgfile/command-not-found.bash" ] && . /usr/share/doc/pkgfile/command-not-found.bash
[ -r "/usr/share/fzf/completion.bash " ] && . /usr/share/fzf/completion.bash
[ -r "/usr/share/fzf/key-bindings.bash" ] && . /usr/share/fzf/key-bindings.bash
[ -r "/usr/share/nvm/init-nvm.sh" ] && . /usr/share/nvm/init-nvm.sh
[ -r "/usr/share/z/z.sh" ] && . /usr/share/z/z.sh

# Load Keychain
eval "$(keychain --eval --quiet --quick --nogui --ignore-missing --agents ssh,gpg \
     id_rsa id_ed25519 B78ABA26623D1326)"
