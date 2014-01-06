BREW_DIR=`brew --prefix`
BREW_BIN="${BREW_DIR}/bin"
BREW_SBIN="${BREW_DIR}/sbin"

PATH="${BREW_SBIN}:${BREW_BIN}:$PATH"

# Add Homebrew Coreutils to Path
MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

brew-pgraph () {
  brew graph | dot -Tpng | open -f -a /Applications/Preview.app
}

function _brew_check_installed () {
  brew ls --versions $1 | grep $1
}

# if _brew_check_installed nimrod; then
#   echo "OK"
# else
#   echo "NOT OK"
# fi
