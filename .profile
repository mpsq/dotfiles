# ~/.profile

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls="exa --color=auto"
alias l="exa -lF --color=auto"
alias la="exa -laF --color=auto"
alias lah="exa -lah --color=auto"
alias lsd='exa -lF --color=auto | grep "^d"'

alias boum='git co master && git pull origin master'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias em="emacsclient -t -a \"emacs -nw\""

# Add local binaries to path
export PATH=$PATH:/home/meril/.local/bin:/home/meril/.yarn/bin:/home/meril/.cargo/bin

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
export GNUPGHOME="/home/meril/.gnupg"
