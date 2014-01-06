# General Terminal Settings
export TERM=xterm-color
export CLICOLOR=true

# General Settings
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_TYPE=de_DE.UTF-8

# History management
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
function hs {
    grep $1 $HISTFILE
}

eval `dircolors ~/.dir_colors`

# Grep Options
export GREP_OPTIONS="--color=auto --exclude=\*.svn\* --exclude=\*.git\* --exclude=\*.log\*"
