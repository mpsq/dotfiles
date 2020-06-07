#!/usr/bin/env bash
# ~/.profile

# Add local binaries to path
export PATH=$PATH:/home/meril/.local/bin
export PATH=$PATH:/home/meril/.yarn/bin
export PATH=$PATH:/home/meril/.cargo/bin
export PATH=$PATH:/home/meril/go/bin
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

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
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland-egl
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_FORCE_DPI=physical
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export XDG_CONFIG_HOME=/home/meril/.config

# gpg
GPG_TTY=$(tty)
export GPG_TTY

export XZ_DEFAULTS="-T 0"
