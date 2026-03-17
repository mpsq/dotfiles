#!/usr/bin/env bash

MAKEFLAGS="-j$(nproc)"
export MAKEFLAGS

[[ -r "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
