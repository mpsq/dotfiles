#!/usr/bin/env bash

PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/local/share/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}
export PKG_CONFIG_PATH

LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

export MAKEFLAGS="-j$(nproc)"

[[ -r "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
