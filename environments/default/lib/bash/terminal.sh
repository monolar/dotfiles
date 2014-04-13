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

eval `dircolors ${LIB}/bash/.dir_colors`

# Grep Options
export GREP_OPTIONS="--color=auto --exclude=\*.svn\* --exclude=\*.git\* --exclude=\*.log\*"

### MISC ###

# Z
. `brew --prefix`/etc/profile.d/z.sh

# Python
#PATH="${BREW_DIR}/share/python3.2:$PATH"
#PATH="${BREW_DIR}/share/python:$PATH"

# Y60
#export PATH=/artcom/bin:$PATH

# npm
# PATH="${BREW_DIR}/lib/node_modules:$PATH"
# PATH="${BREW_DIR}/share/npm/bin:$PATH"
