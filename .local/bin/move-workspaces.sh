#!/usr/bin/env bash

set -eo pipefail

current_workspace=$(swaymsg -t get_workspaces | jq '.[]|select(.focused) | .name')
laptop="eDP-1"
screen="DP-1"

case $1 in
work)
  for i in 1 2 3 4 5 6 7 8 9; do
    swaymsg workspace $i && swaymsg "move workspace to output $screen"
    swaymsg workspace "$current_workspace"
  done
  ;;
nomad)
  for i in 1 2 3 4 5 6 7 8 9; do
    swaymsg workspace $i && swaymsg "move workspace to output $laptop"
    swaymsg workspace "$current_workspace"
  done
  ;;
*)
  echo "usage $0 [work|nomad]"
  ;;
esac

notify-send shikane \"profile $1 has been applied\"
