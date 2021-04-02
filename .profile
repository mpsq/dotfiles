#!/usr/bin/env bash
# ~/.profile

# PATH
export PATH=$PATH:/home/meril/.local/bin
export PATH=$PATH:/home/meril/.yarn/bin
export PATH=$PATH:/home/meril/.cargo/bin
export PATH=$PATH:/home/meril/go/bin
export PATH=$PATH:/home/meril/.emacs.d/bin
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

# Better history
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:gpg"

# Default apps
export EDITOR="em"
export VISUAL="em"
export BROWSER="firefox"

# Wayland compat
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME="qt5ct"
export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1

# Homes
export XDG_CURRENT_DESKTOP="sway"
export XDG_CONFIG_HOME="/home/meril/.config"
export DOOMDIR="$XDG_CONFIG_HOME/doom-emacs"
export GNUPGHOME="$HOME/.gnupg"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export NVM_DIR="$HOME/.nvm"
export NVM_SOURCE="/usr/share/nvm"

# fzf
export FZF_DEFAULT_OPTS="--bind=ctrl-l:accept"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#cbe3e7,bg:#100e23,hl:#91ddff'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg+:#a6b3cc,bg+:#565575,hl+:#65b2ff'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=info:#95ffa4,prompt:#ff8080,pointer:#906cff'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=marker:#62d196,spinner:#c991e1,header:#ffe9aa'

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# Misc.
[ -r "$XDG_CONFIG_HOME/priv/stuff.bash" ] && . "$XDG_CONFIG_HOME/priv/stuff.bash"
