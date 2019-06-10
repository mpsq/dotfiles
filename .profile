# ~/.profile

# Load keychain
eval $(keychain --eval --quiet --nogui --agents ssh,gpg id_rsa B78ABA26623D1326)

# Load Hub
[ -x "$(command -v hub)" ] && eval "$(hub alias -s)"

# Import z
[ -r "/usr/share/z/z.sh" ] && source /usr/share/z/z.sh

# Import nvm
[ -r "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh

# Load auto-completion
[ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion

# Import fzf
[ -r "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash
[ -r "/usr/share/fzf/completion.bash " ] && source /usr/share/fzf/completion.bash

# Import any additional secrets
[ -r ~/.secrets ] && source ~/.secrets

# Add local binaries to path
export PATH=$PATH:/home/meril/.local/bin:/home/meril/.yarn/bin:/home/meril/.cargo/bin

# Better history
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Default apps
export EDITOR="emacsclient"
export VISUAL="emacsclient -c -a emacs"
export BROWSER="chromium"
export GNUPGHOME="/home/meril/.gnupg"

# Colours
if type -P dircolors >/dev/null ; then
    LS_COLORS=

    if [[ -f ~/.dir_colors ]] ; then
        used_default_dircolors="no"
        eval "$(dircolors -b ~/.dir_colors)"
    else
        used_default_dircolors="yes"
        eval "$(dircolors -b)"
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
