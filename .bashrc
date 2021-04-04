#!/usr/bin/env bash
# ~/.bashrc
# shellcheck disable=SC1091,SC1090

if [[ "$TERM" == "dumb" ]]; then
    export PS1='\u at \h in \w\n\$ '
    exit 0
fi

# Better history
shopt -s checkwinsize
shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
set -o ignoreeof

# Disable ctrl-s sending XOFF
stty ixany
stty ixoff -ixon

# Colours
if [[ $(hash dircolors 2> /dev/null) ]] && [ -f "$HOME/.dir_colors" ]; then
    eval "$(dircolors -b ~/.dir_colors)"
fi

function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

git_branch="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \"\|)\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \|)"

txtcyn='\e[0;36m' # Cyan
txtprl='\e[1;35m' # Purple
bldblu='\e[1;34m' # Bold Blue
txtrst='\e[0m'    # Text Reset
export PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtrst\]\[$txtprl\]$git_branch\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"

# Source things
[ -r "$HOME/.aliases" ] && . "$HOME/.aliases"
[ -r "/usr/share/z/z.sh" ] && . /usr/share/z/z.sh
[ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion
[ -r "/usr/share/skim/completion.bash " ] && . /usr/share/skim/completion.bash
[ -r "/usr/share/skim/key-bindings.bash" ] && . /usr/share/skim/key-bindings.bash
[ -r "/usr/share/doc/pkgfile/command-not-found.bash" ] && . /usr/share/doc/pkgfile/command-not-found.bash
[ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    function clear(){
        printf  "\e]51;E(vterm-clear-scrollback)\e\\";
        tput clear;
    }
else
    # Enable vi mode
    set -o vi
fi
