#!/usr/bin/env bash
# ~/.profile

# Add local binaries to path
export PATH=$PATH:/home/meril/.local/bin
export PATH=$PATH:/home/meril/.yarn/bin
export PATH=$PATH:/home/meril/.cargo/bin
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
export BROWSER="chromium"
export GNUPGHOME="$HOME/.gnupg"

# Wayland apps
export XDG_SESSION_TYPE=wayland
export MOZ_ENABLE_WAYLAND=1

# gpg
GPG_TTY=$(tty)
export GPG_TTY
