#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# TODO: Be more defensively

function _get_root_permissions() {
  echo "* getting root permissions once at the start..."
  # Ask for the administrator password upfront.
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished.
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

_get_root_permissions

which -s brew
if [[ $? != 0 ]] ; then
    echo "* install homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "* update homebrew ..."
    brew update
fi

echo "* checking homebrew ..."
brew doctor

function _taps() {
  taps=(
    # codeclimate/formulae
    # homebrew/science
    # homebrew/python
    # adymo/kde
    # thoughtbot/formulae
  )
  for i in "${taps[@]}"
  do
   :
   echo "tapping '${i}' ..."
   brew tap $i
  done
}

_taps

# TODO brew upgrade --cask
echo "Do you wish to upgrade all packages?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "* Upgrade all packages"; brew upgrade; break;;
        No ) echo "* Continue without upgrading packages"; break;;
    esac
done

# Formulae
echo "* brewing formulae ..."

# Shells and core CLI
brew install bash fish
brew install bash-completion2
brew install coreutils
brew install binutils
brew install grep
brew install findutils
brew install gnu-tar
brew install gawk
brew install z
brew install grc
brew install reattach-to-user-namespace
brew install tree
brew install watch
brew install pick # for picking stuff from big lists
brew install pv # Pipeline

# Editors and terminal workflow
brew install vim --override-system-vi
brew install vimpager
brew install neovim
brew install tmux
brew install ranger
brew install midnight-commander
brew install ghostty # a nice terminal emulator

# Search, navigation, and inspection
brew install htop
brew install pstree
brew install the_silver_searcher # faster search
brew install ripgrep # rust powered grep/ag alternative
brew install fd # find alternative (gitignore aware)
brew install fzf # command line fuzzy finder
brew install ctags
brew install cloc # source code line counter
brew install bat # cat for markdown
brew install jq # Command line json processor
brew install jsonpp # Command line json pretty printer
brew install csvkit # nice tools for csv operations

# Version control and dotfiles
brew install git
brew install subversion
brew install mercurial # Source code versioning system
brew install tig
brew install stow

# Languages and build tooling
brew install cmake
brew install python
brew install pyenv
brew install pyenv-virtualenv
brew install pipenv
brew install node
brew install go
brew install rust
brew install crystal
brew install nim
brew install stack
brew install rbenv ruby-build
brew install qt
brew install pyqt
brew install v8
brew install zlib
brew install zig

# Networking, HTTP, and infrastructure
brew install httpie
brew install wget
brew install nginx
brew install haproxy
brew install watchman # watch fs changes
brew install watchexec # watch fs changes (gitignore aware)
brew install docker-compose

# Databases and services
brew install sqlite
brew install mysql@8.0
brew install mysql-client
brew install redis
brew install memcached
brew install memcache-top
brew install neo4j # Graph Database

# Security and certificates
brew install gpg

# Data, docs, and utilities
brew install graphviz
brew install qcachegrind # for profile data visualisation
brew install since
brew install logtalk # prolog inspired programming language
brew install zopfli # compression algorithm
brew install lcov

# Imaging and graphics
brew install libtiff
brew install libjpeg
brew install webp
brew install little-cms2
brew install imagemagick
brew install cairo
brew install gifsicle # for optimizing GIFs

# Casks
echo "installing Cask Applications..."

# Cloud and containers
brew install --cask google-cloud-sdk
brew install --cask docker
brew install --cask virtualbox
brew install --cask tunnelblick # A VPN Client
brew install --cask vyprvpn

# Developer IDEs and editors
brew install --cask intellij-idea-ce
brew install --cask pycharm-ce
brew install --cask visual-studio-code
brew install --cask github # Github ui client
brew install --cask tower # tower2 git ui client
brew install --cask sourcetree # another git client
brew install --cask gitkraken # some git ui
brew install --cask versions # svn ui client

# Java and API tooling
brew install --cask temurin
brew install gradle # Java build tool like maven
brew install --cask postman
brew install --cask insomnia # REST ui Testing tool
brew install --cask soapui # REST ui Testing workbench
brew install --cask paw # api tool
brew install --cask cocoarestclient

# Database clients
brew install --cask mysqlworkbench
brew install --cask sequel-ace # Sql workbench
brew install --cask tableplus # another sql workbench (also supports REDIS!!)
brew install --cask datagrip # Jetbrains' take on sql workbench
brew install --cask dbvisualizer

# Terminal and shell utilities
brew install --cask iterm2 # Terminal alternative
brew install --cask alacritty # gpu based terminal emulator
brew install --cask servpane # convenient way to start/stop brew services from menubar
brew install --cask clipy # A Clipboard extension

# Communication and collaboration
brew install --cask slack # Messaging
brew install --cask adium # Chat client
brew install --cask skype
brew install --cask whatsapp # yeah, i know

# Browsers and productivity
brew install --cask firefox
brew install --cask libreoffice
brew install --cask fantastical # iCal alternative
brew install --cask macdown # Another Markdown editor

# Media, design, and graphics
brew install --cask xquartz
brew install --cask imageoptim # Image Optimizer
brew install --cask licecap # Record animated gifs
brew install --cask gimp # image manipulation
brew install --cask inkscape
brew install --cask fontforge
brew install --cask blender # i like modelling and do papercraft stuff.
brew install --cask vlc

# System utilities and inspection
brew install --cask onyx # OS X maintenance and power tools
brew install --cask disk-inventory-x # file system overview
brew install --cask jewelrybox # RVM UI

# Commercial or optional desktop apps
brew install --cask beyond-compare # diff/merge ui tool
brew install --cask deltawalker # diff/merge ui tool
brew install --cask kaleidoscope # diff/merge ui tool
brew install --cask steam # i am a gamer

# Quick Look plugins
brew install --cask qlmarkdown # markdown
brew install --cask quicklook-json

echo "Cleaning Brews..."
brew cleanup

# Initialize rbenv after installation
if command -v rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi
