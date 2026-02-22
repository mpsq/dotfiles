#!/usr/bin/env bash
# shellcheck disable=SC1091,SC1090

# If TTY
if tty | grep -q tty; then
  export GPG_TTY=$(tty)
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
    while [ $# -gt 0 ]; do
      vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
      shift
    done
    vterm_printf "51;E$vterm_elisp"
  }

  function vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
  }
fi

hname=$(hostname)

# Better history
shopt -s checkwinsize
shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
set -o ignoreeof
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:gpg"

# Disable ctrl-s sending XOFF
stty ixany
stty ixoff -ixon

# Pager / man
export LESS='-RX --mouse --quit-if-one-screen -Dd+r$Du+b'
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export PAGER="less -rX"
export MANWIDTH=92

function parse_git_dirty() {
  [[ -n $(git status --porcelain 2>/dev/null) ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2>/dev/null |
    sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function include() {
  [[ -r "$1" ]] && source "$1"
}

txtcyn='\e[0;36m' # Cyan
txtprl='\e[1;35m' # Purple
bldblu='\e[1;34m' # Bold Blue
txtrst='\e[0m'    # Text Reset
git_branch="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \"\|)\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \|)"
PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtrst\]\[$txtprl\]$git_branch\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"
PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}:${PWD}\007"'

# gpg / ssh agent integration
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Source things
include /usr/share/z/z.sh
include /usr/share/bash-completion/bash_completion
include /usr/share/fzf/completion.bash
include /usr/share/fzf/key-bindings.bash
include /usr/share/doc/pkgfile/command-not-found.bash
include "$HOME/.config/sh/vars"
include "$XDG_CONFIG_HOME/sh/aliases"
include "$HOME/.$hname-bashrc"

if command -v direnv >/dev/null; then
  eval "$(direnv hook bash)"
fi

if command -v dircolors >/dev/null; then
  eval $(dircolors)
fi

if [ -s "/usr/share/nvm/init-nvm.sh" ]; then
  _nvm_lazy_load() {
    unset -f nvm node npm npx yarn
    \. "/usr/share/nvm/init-nvm.sh"
  }
  nvm()  { _nvm_lazy_load; nvm  "$@"; }
  node() { _nvm_lazy_load; node "$@"; }
  npm()  { _nvm_lazy_load; npm  "$@"; }
  npx()  { _nvm_lazy_load; npx  "$@"; }
  yarn() { _nvm_lazy_load; yarn "$@"; }
fi

if [[ ! -v INSIDE_EMACS ]]; then
  set -o vi
else
  PS1=$PS1'\[$(vterm_prompt_end)\]'
fi
