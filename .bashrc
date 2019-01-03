# ~/.bashrc

alias boum='git co master && git pull origin master'
alias undopush="git push -f origin HEAD^:master"

alias locks="rm -rf node_modules && rm yarn.lock && yarn && rm package-lock.json && rm -rf node_modules && npm i"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control
shopt -s checkwinsize

# Disable completion when the input buffer is empty
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Save multi-line commands as one command
shopt -s cmdhist

# Shell only exists after the 10th consecutive Ctrl-d. Same as IGNOREEOF=10
set -o ignoreeof

# Add local binaries to path
export PATH=$PATH:~/.local/bin

# Better history
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Default apps
export EDITOR="emacsclient"
export VISUAL="emacsclient -c -a emacs"
export BROWSER="chromium"
export GNUPGHOME="~/.gnupg"
