# ~/.bashrc

# Disable ctrl-s sending XOFF
stty ixany
stty ixoff -ixon

eval $(keychain --eval --quiet --nogui --agents ssh,gpg id_rsa id_ed25519 B78ABA26623D1326)

# Colours
if type -P dircolors >/dev/null ; then
    LS_COLORS=

    if [[ -f ~/.dir_colors ]] ; then
        used_default_dircolors="no"
        eval "$(dircolors -b ~/.dir_colors)"
    fi

    if [[ -n ${LS_COLORS:+set} ]] ; then
        use_color=true
    fi

    unset used_default_dircolors
fi

# Man pages
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

[ -r "/usr/share/z/z.sh" ] && . /usr/share/z/z.sh

[ -r "/usr/share/nvm/init-nvm.sh" ] && . /usr/share/nvm/init-nvm.sh

[ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion

[ -r "/usr/share/doc/pkgfile/command-not-found.bash" ] && . /usr/share/doc/pkgfile/command-not-found.bash

[ -r "/usr/share/fzf/key-bindings.bash" ] && . /usr/share/fzf/key-bindings.bash
[ -r "/usr/share/fzf/completion.bash " ] && . /usr/share/fzf/completion.bash

[ -r ~/.secrets ] && . ~/.secrets

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

function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Some Colours
txtcyn='\e[0;36m' # Cyan
txtprl='\e[1;35m' # Purple
bldblu='\e[1;34m' # Bold Blue
bldylw='\e[1;33m' # Bold Yellow
txtrst='\e[0m'    # Text Reset

prompt_git="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \"\|)\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \|)"

export PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtrst\]\[$txtprl\]$prompt_git\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"
