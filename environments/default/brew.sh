#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# TODO: Be more defensively

function _get_root_permissions() {
  echo "getting root permissions once at the start..."
  # Ask for the administrator password upfront.
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished.
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

_get_root_permissions

# XCode sdk
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "checking brew..."
brew doctor

function _taps() {
  taps=(
    codeclimate/formulae
    caskroom/cask
    caskroom/versions
    homebrew/dupes
    homebrew/versions
    manastech/crystal
    martido/brew-graph
    homebrew/science
    homebrew/python
    adymo/kde
    thoughtbot/formulae
  )
  for i in "${taps[@]}"
  do
   :
   echo "tapping '${i}' ..."
   brew tap $i
  done
}

_taps

# Make sure we’re using the latest Homebrew.
#echo "updating brews..."
#brew update

# Upgrade any already-installed formulae.
#echo "upgrading brews..."
#brew upgrade

# All "normal" brew packages...
echo "... brewing ..."
brew install brew-graph
brew install bash fish
brew install bash-completion2
brew install coreutils
brew install binutils
brew install git --with-brewed-curl --with-brewed-openssl --with-brewed-svn --with-gettext
brew install gitsh
brew install grep --with-default-names
brew install z
brew install sqlite
brew install gpg
brew install grc
brew install findutils --with-default-names
brew install gnu-tar --with-default-names
brew install gawk
brew install reattach-to-user-namespace
brew install cmake --with-completion
brew install python
brew install vim --override-system-vi
brew install tmux ranger htop wget
brew install the_silver_searcher # faster search
brew install fzf # command line fuzzy finder
brew install ctags stow
brew install mysql node tree tig
brew install crystal-lang
brew install graphviz --with-librsvg --with-x11
brew install nginx httpie
brew install go haskell-stack nimrod
brew install zopfli # compression algorithm
brew install watch thefuck
brew install the_platinum_searcher
brew install since pup pstree
brew install neo4j # Graph Database
brew install mercurial # Source code versioning system
brew install v8 haproxy midnight-commander
brew install logtalk # prolog inspired programming language
brew install qcachegrind # for profile data visualisation
brew install qt --with-d-bus --with-qt3support
brew install gifsicle # for optimizing GIFs
brew install pick # for picking stuff from big lists
brew install cloc # source code line counter
brew install pv # Pipeline

# install PIL, imagemagick, graphviz and other
# image generating stuff
brew install libtiff libjpeg webp little-cms2

brew install imagemagick --with-fftw --with-librsvg --with-x11
brew install cairo

brew install Caskroom/cask/intellij-idea

# Install brew cask
brew install caskroom/cask/brew-cask
brew install Caskroom/cask/xquartz

brew install py2cairo # this will ask you to download xquartz and install it
brew install pyqt

brew install adymo/kde/massif-visualizer # for memory profile visualisation
brew install watchman # watch fs changes
brew install memcache-top

# Docker
brew install docker-machine
brew install codeclimate
brew install docker
brew install docker-compose

# Install cask applications
echo "installing Cask Applications..."

brew install Caskroom/cask/easysimbl
echo "Starting EasySIMBL: Check 'Use SIMBL' checkbox..."
open ~/Applications/EasySIMBL.app

brew install Caskroom/cask/iterm2 # Terminal alternative
brew install Caskroom/cask/mou # Markdown Editor
brew install Caskroom/cask/google-chrome # Browser
brew install Caskroom/cask/slack # Messaging
brew install Caskroom/cask/adium # Chat client
brew install Caskroom/cask/java
brew install gradle # Java build tool like maven
brew install Caskroom/cask/mysqlworkbench
brew install Caskroom/cask/github-desktop # Github ui client
brew install Caskroom/cask/sequel-pro # Sql workbench
brew install Caskroom/cask/atom # Editor
brew install Caskroom/cask/jewelrybox # RVM UI
brew install Caskroom/cask/cocoarestclient
brew install Caskroom/cask/macdown # Another Markdown editor
brew install Caskroom/cask/skype
brew install Caskroom/cask/virtualbox
brew install Caskroom/cask/imageoptim # Image Optimizer
brew install Caskroom/cask/licecap # Record animated gifs
brew install Caskroom/cask/gimp # image manipulation
brew install Caskroom/cask/onyx # OS X maintenance and power tools
brew install Caskroom/cask/secrets # OS X settings panel
brew install Caskroom/cask/firefox
brew install Caskroom/cask/spectacle # manage windows and their positions
brew install Caskroom/cask/cakebrew # Brew UI client
brew install Caskroom/cask/fontforge
brew install Caskroom/cask/blender # i like modelling and do papercraft stuff.
brew install Caskroom/cask/steam # i am a gamer
brew install Caskroom/cask/vlc
## Commercial Cask Applications (may work as trial)
brew install Caskroom/versions/sublime-text3
brew install Caskroom/cask/tower # installs tower2
brew install Caskroom/cask/libreoffice # productivity stuff you cannot without
brew install Caskroom/cask/kitematic # Docker
brew install Caskroom/cask/disk-inventory-x # file system overview
brew install Caskroom/cask/dbvisualizer
brew install Caskroom/cask/sourcetree # another git client
brew install Caskroom/cask/rdm # redis ui client
brew install Caskroom/cask/clipy # A Clipboard extension

# Quicklook plugins
brew install Caskroom/cask/qlmarkdown # markdown

echo "Cleaning Brews..."
brew cleanup

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
