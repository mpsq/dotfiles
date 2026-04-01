#!/usr/bin/env bash
# shellcheck disable=SC1090

# If interactive terminal
if [[ -t 0 ]]; then
  GPG_TTY=$(tty)
  export GPG_TTY
  echo "UPDATESTARTUPTTY" | gpg-connect-agent >/dev/null 2>&1
fi

if [[ "$INSIDE_EMACS" == 'vterm' ]]; then
  function vterm_printf() {
    printf "\e]%s\e\\" "$1"
  }

  function clear() {
    vterm_printf "51;Evterm-clear-scrollback"
    tput clear
  }

  function vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [[ $# -gt 0 ]]; do
      vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
      shift
    done
    vterm_printf "51;E$vterm_elisp"
  }

  function vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
  }
fi

# Variables
[[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/sh/vars" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/sh/vars"

# Better history
shopt -s checkwinsize
shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
shopt -s globstar
shopt -s direxpand
shopt -s no_empty_cmd_completion
shopt -s patsub_replacement
set -o ignoreeof
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/bash/history"
mkdir -p "${HISTFILE%/*}" 2>/dev/null
export HISTCONTROL="erasedups:ignorespace"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:gpg"

# Disable ctrl-s sending XOFF
[[ -t 0 ]] && stty -ixon

# Pager / man
export LESS="-RX --mouse --quit-if-one-screen -Dd+r\$Du+b"
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export PAGER=less
export MANWIDTH=92

function include() {
  [[ -r "$1" ]] && source "$1"
}

mkcd() { mkdir -p "$1" && cd "$1" || return; }

up() {
  local d=""
  for ((i = 1; i <= ${1:-1}; i++)); do d="../$d"; done
  cd "$d" || return
}

jctl() {
  if [[ "$*" == *"-f"* ]]; then
    journalctl "$@" | bat --paging=never -l syslog
  else
    journalctl "$@" | bat -l syslog
  fi
}

include /usr/share/git/completion/git-prompt.sh
command -v __git_ps1 &>/dev/null || __git_ps1() { :; }

txtcyn='\e[0;36m' # Cyan
txtprl='\e[1;35m' # Purple
bldblu='\e[1;34m' # Bold Blue
txtrst='\e[0m'    # Text Reset
PROMPT_DIRTRIM=3
PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtprl\]\$(__git_ps1 ' |%s|')\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"
PROMPT_COMMAND=('history -a' 'printf "\e]0;%s:%s\a" "${HOSTNAME}" "${PWD}"')

include "${XDG_CONFIG_HOME:-$HOME/.config}/sh/aliases"

# Integration
if command -v direnv >/dev/null; then
  eval "$(direnv hook bash)"
fi

if command -v dircolors >/dev/null; then
  eval "$(dircolors)"
fi
if command -v zoxide >/dev/null; then
  eval "$(zoxide init bash)"
fi
include /usr/share/bash-completion/bash_completion
include /usr/share/fzf/completion.bash
include /usr/share/fzf/key-bindings.bash
include /usr/share/doc/pkgfile/command-not-found.bash
include "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/noctalia-theme.sh"
include "$NVM_DIR/nvm.sh"
if command -v mise >/dev/null; then
  eval "$(mise activate bash)"
fi

# PS1 / Emacs support
if [[ ! -v INSIDE_EMACS ]]; then
  set -o vi
elif [[ "$INSIDE_EMACS" == 'vterm' ]]; then
  PS1=$PS1'\[$(vterm_prompt_end)\]'
fi
