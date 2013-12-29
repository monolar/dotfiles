# General Terminal Settings
export TERM=xterm-color
export CLICOLOR=true

# History management
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
function hs {
    grep $1 $HISTFILE
}

# man pages
pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

# Homebrew Path Fix
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# nimrod
PATH="/usr/local/Cellar/nimrod/0.9.2/libexec/bin:$PATH"

# Completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
# custom completions
source ~/vagrant_completion.sh

# Z
. `brew --prefix`/etc/profile.d/z.sh

# Python

PATH="/usr/local/share/python3.2:$PATH"
#PATH="/usr/local/share/python:$PATH"

# General Settings
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_TYPE=de_DE.UTF-8

# Y60
#export PATH=/artcom/bin:$PATH

# Custom user executables
export PATH=~/bin:$PATH

# RVM
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
# In case we use Jruby we want 1.9 to be the default
export JRUBY_OPTS=--1.9

# Add Homebrew Coreutils to Path
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# npm
PATH="/usr/local/lib/node_modules:$PATH"
PATH="/usr/local/share/npm/bin:$PATH"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

# Credits to npm's. Awesome completion utility.
#
# Bower completion script, based on npm completion script.

###-begin-bower-completion-###
#
# Installation: bower completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: bower completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _bower_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           bower completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _bower_completion bower
elif type compdef &>/dev/null; then
  _bower_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 bower completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _bower_completion bower
elif type compctl &>/dev/null; then
  _bower_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       bower completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _bower_completion bower
fi
###-end-bower-completion-###

# Vim in less mode alias
alias vless="/usr/share/vim/vim73/macros/less.sh"

# LS Settings
alias ls="ls --color=auto"
alias la="ls --color=auto -laF"

eval `dircolors ~/.dir_colors`

# Grep Options
export GREP_OPTIONS="--color=auto --exclude=\*.svn\* --exclude=\*.git\* --exclude=\*.log\*"

########################
# Rake bash-completion #
########################
function _rake_cache_path() {
    # If in a Rails app, put the cache in the cache dir
    # so version control ignores it
    if [ -e 'tmp/cache' ]; then
        prefix='tmp/cache/'
    fi
    echo "${prefix}.rake_t_cache"
}

function rake_cache_store() {
    rake --tasks --silent > "$(_rake_cache_path)"
}

function rake_cache_clear() {
    rm -f .rake_t_cache
    rm -f tmp/cache/.rake_t_cache
}

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

function _rakecomplete() {
      # error if no Rakefile
    if [ ! -e Rakefile ]; then
        echo "missing Rakefile"
        return 1
    fi

    # build cache if missing
    if [ ! -e "$(_rake_cache_path)" ]; then
        rake_cache_store
    fi

    local tasks=`awk '{print $2}' "$(_rake_cache_path)"`
    COMPREPLY=($(compgen -W "${tasks}" -- ${COMP_WORDS[COMP_CWORD]}))
    return 0
}

complete -o default -o nospace -F _rakecomplete rake
##############################
# Capistrano bash-completion #
##############################
_capcomplete() {
    if [ ! -e Capfile ]; then
        return
    fi
    complete -W "$(cap -T | grep '#' | awk 'NR != 1 {print $2}')" cap
    return 0
}
complete -o default -o nospace -F _capcomplete cap

###############
# GIT SUPPORT #
###############
source ~/.git_completion.sh
#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# Returns "*" if the current git branch is dirty.
function parse_git_dirty {
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "🔴 "
}

# Returns "|shashed:N" where N is the number of stashed states (if any).
function parse_git_stash {
    local stash=`expr $(git stash list 2>/dev/null| wc -l)`
    if [ "${stash}" != "0" ]
    then
        echo "|stashed:$stash"
    fi
}

# Get the current git branch name (if available)
git_prompt() {
    local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
    if [ "${ref}" != "" ]
    then
        echo "($ref$(parse_git_dirty)$(parse_git_stash)) "
    fi
}

alias lg="git log --decorate --graph --oneline"

RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
YELLOW="\[\033[33;1m\]"
WHITE="\[\033[37;1m\]"
#SMILEY="${WHITE}:)${NORMAL}"
#FROWNY="${RED}:(${NORMAL}"
SMILEY="😊 "
FROWNY="😕 "
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

last_state() {
  if [ $? = 0 ];
    then
      #echo ":)";
      echo "${SMILEY}";
    else
      #echo ":(";
      echo "${FROWNY}";
    fi
}

current_rvm() {
      echo `rvm current`
}

export PS1='\[\e[01;32m\]\u@\h:\[\e[01;34m\]\W \[\e[01;36m\]$(last_state) \[\e[01;33m\][rvm:$(current_rvm)]  \[\e[01;35m\]$(git_prompt)\[\e[01;33m\]$\[\e[0m\] '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
