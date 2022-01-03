#!/usr/bin/env bash
# ~/.bashrc
# shellcheck disable=SC1091,SC1090

vterm_printf() {
  printf "\e]%s\e\\" "$1"
}

vterm_cmd() {
  local vterm_elisp
  vterm_elisp=""
  while [ $# -gt 0 ]; do
    vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
    shift
  done
  vterm_printf "51;E$vterm_elisp"
}

vterm_prompt_end() {
  vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}

parse_git_dirty() {
  if [[ $(git status 2>/dev/null | tail -n1) != *"working directory clean"* ]]; then
    echo "*"
  fi
}

parse_git_branch() {
  git branch --no-color 2>/dev/null |
    sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# If TTY
if tty | grep -q tty; then
  export GPG_TTY=$(tty)
  echo "UPDATESTARTUPTTY" | gpg-connect-agent >/dev/null 2>&1
fi

if [[ "$TERM" != "dumb" ]]; then
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

  if command -v dircolors >/dev/null; then
    eval $(dircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)
  fi

  # Pager / man
  export LESS='-RX --mouse --quit-if-one-screen -Dd+r$Du+b'
  export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
  export PAGER="less -rX"
  export MANWIDTH=92

  txtcyn='\e[0;36m' # Cyan
  txtprl='\e[1;35m' # Purple
  bldblu='\e[1;34m' # Bold Blue
  txtrst='\e[0m'    # Text Reset
  git_branch="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \"\|)\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \|)"
  PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtrst\]\[$txtprl\]$git_branch\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"
  PS1=$PS1'\[$(vterm_prompt_end)\]'
  PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}:${PWD}\007"'

  if [[ "$INSIDE_EMACS" == 'vterm' ]]; then
    function clear() {
      vterm_printf "51;Evterm-clear-scrollback"
      tput clear
    }
  elif [[ "$TERM" == "xterm-256color" ]]; then
    # Enable vi mode
    set -o vi
  fi

  # Source things
  [ -r "$HOME/.aliases" ] && . "$HOME/.aliases"
  [ -r "/usr/share/z/z.sh" ] && . /usr/share/z/z.sh
  [ -r "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion
  [ -r "/usr/share/skim/completion.bash " ] && . /usr/share/skim/completion.bash
  [ -r "/usr/share/skim/key-bindings.bash" ] && . /usr/share/skim/key-bindings.bash
  [ -r "/usr/share/doc/pkgfile/command-not-found.bash" ] && . /usr/share/doc/pkgfile/command-not-found.bash
  [ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"
  [ -s "$HOME/.$hname-bashrc" ] && . "$HOME/.$hname-bashrc"
  . ~/.profile

  # .envrc integration
  if command -v direnv >/dev/null; then
    eval "$(direnv hook bash)"
  fi
fi
