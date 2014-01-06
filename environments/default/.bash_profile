# Find out where we are.
# Thanks to http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
LIB="${DIR}/lib"

# Load Homebrew specific profile settings.
source "${LIB}/homebrew/env.sh"

# Load general bash settings.
source "${LIB}/bash/terminal.sh"

# Aliasses
source "${LIB}/bash/alias.sh"

# git
source "${LIB}/git/env.sh"

# Other user settings
source "${LIB}/bash/user.sh"

# rvm settings
source "${LIB}/rvm/env.sh"

# Load our prompt
source "${LIB}/bash/prompt.sh"

# nimrod
PATH="$(brew --prefix nimrod)/libexec/bin:$PATH"

# Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# custom completions
source ~/vagrant_completion.sh

# Z
. `brew --prefix`/etc/profile.d/z.sh

# Python

PATH="/usr/local/share/python3.2:$PATH"
#PATH="/usr/local/share/python:$PATH"

# Y60
#export PATH=/artcom/bin:$PATH

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
