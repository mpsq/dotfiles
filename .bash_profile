#!/usr/bin/env bash

[ -r "$XDG_CONFIG_HOME/sh/vars" ] && . "$XDG_CONFIG_HOME/sh/vars"

systemctl --user reset-failed

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/share/pkgconfig:$PKG_CONFIG_PATH

export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH

#[ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
