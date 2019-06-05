# ~/.bashrc

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

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control
shopt -s checkwinsize

# Disable completion when the input buffer is empty
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting
shopt -s histappend

# Autocorrect typos in path names when using cd
shopt -s cdspell

# Save multi-line commands as one command
shopt -s cmdhist

# Shell only exists after the 10th consecutive Ctrl-d. Same as IGNOREEOF=10
set -o ignoreeof

# Git branch details
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Some Colours
txtcyn='\e[0;36m' # Cyan
txtprl='\e[1;35m' # Purple
bldblu='\e[1;34m' # Bold Blue
bldylw='\e[1;33m' # Bold Yellow
txtrst='\e[0m'    # Text Reset

prompt_git="\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \"\|)\$(parse_git_branch)\$([[ -n \$(git branch 2> /dev/null) ]] && echo \|)"

export PS1="\[$bldblu\]\u\[$txtrst\] \w\[$txtrst\]\[$txtprl\]$prompt_git\[$txtrst\]\[$txtcyn\]\n= \[$txtrst\]"

# Some Colours
txtcyn='\e[0;36m' # Cyan
bldblu='\e[1;34m' # Bold Blue
bldylw='\e[1;33m' # Bold Yellow
txtrst='\e[0m'    # Text Reset
