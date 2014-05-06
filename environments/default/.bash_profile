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

# Git Settings
source "${LIB}/git/env.sh"

# Other user settings
source "${LIB}/bash/user.sh"

# Java Setting
source "${LIB}/java/env.sh"

# Maven Settings
source "${LIB}/maven/env.sh"

# Android SDK Settings
source "${LIB}/android/env.sh"

# NPM Settings
source "${LIB}/npm/env.sh"

# NIMROD Settings
source "${LIB}/nimrod/env.sh"

# Completion scripts
source "${LIB}/bash/completion/base.sh"
source "${LIB}/bash/completion/rake.sh"
source "${LIB}/bash/completion/capistrano.sh"
source "${LIB}/bash/completion/npm.sh"
source "${LIB}/bash/completion/bower.sh"
source "${LIB}/bash/completion/vagrant.sh"
source "${LIB}/bash/completion/maven.sh"
source "${LIB}/bash/completion/gem.sh"
source "${LIB}/bash/completion/bundle.sh"
source "${LIB}/bash/completion/ruby.sh"
source "${LIB}/bash/completion/nimrod.sh"

# GRC configs & aliasing
source "${LIB}/grc/env.sh"

# rvm settings
source "${LIB}/rvm/env.sh"

# Load our prompt
source "${LIB}/bash/prompt.sh"

ulimit -S -n 65535
