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
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "* update homebrew ..."
    brew update
fi

echo "* checking homebrew ..."
brew doctor

function _taps() {
  taps=(
    # codeclimate/formulae
    martido/brew-graph
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

# TODO brew cask upgrade
echo "Do you wish to upgrade all packages?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "* Upgrade all packages"; brew upgrade; break;;
        No ) echo "* Continue without upgrading packages"; break;;
    esac
done

# All "normal" brew packages...
echo "* brewing ..."
brew install brew-graph
brew install bash fish
brew install bash-completion2
brew install coreutils
brew install binutils
brew install git --with-curl --with-openssl
brew install git-sh
brew install subversion
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
brew install pyenv
brew install pyenv-virtualenv
# brew install pyenv-virtualenvwrapper
brew install vim --override-system-vi
brew install tmux
brew install ranger
brew install htop
brew install pstree
brew install the_silver_searcher # faster search
brew install fzf # command line fuzzy finder
brew install ctags
brew install stow
brew install mysql@5.7 # We are not yet using mysql 8
brew install mysql-client
brew install node
brew install tree
brew install tig
brew install crystal
brew install rust
brew install graphviz --with-librsvg --with-x11
brew install nginx
brew install httpie
brew install wget
brew install go
brew install haskell-stack nimrod
brew install zopfli # compression algorithm
brew install watch
brew install thefuck
brew install the_platinum_searcher
brew install since
brew install pup
brew install mercurial # Source code versioning system
brew install v8 haproxy midnight-commander
brew install logtalk # prolog inspired programming language
brew install qcachegrind # for profile data visualisation
brew install qt --with-d-bus --with-qt3support
brew install gifsicle # for optimizing GIFs
brew install pick # for picking stuff from big lists
brew install cloc # source code line counter
brew install pv # Pipeline
brew install jq # Command line json processor
brew install jsonpp # Command line json pretty printer
brew install zlib
brew install redis
brew install memcached

# install PIL, imagemagick, graphviz and other
# image generating stuff
brew install libtiff
brew install libjpeg
brew install webp
brew install little-cms2

brew cask install xquartz
brew install imagemagick --with-fftw --with-librsvg --with-x11
brew install cairo

brew install py2cairo # this will ask you to download xquartz and install it
brew install pyqt

# brew install adymo/kde/massif-visualizer # for memory profile visualisation
brew install watchman # watch fs changes
brew install memcache-top

# Docker
# brew install docker-machine
# brew install codeclimate
brew install docker
brew install docker-compose

echo "installing Cask Applications..."
brew cask install docker

# Java8 and neo4j
brew cask install java8
brew install neo4j # Graph Database

brew cask install intellij-idea-ce
brew cask install pycharm-ce

# brew install Caskroom/cask/easysimbl
# echo "Starting EasySIMBL: Check 'Use SIMBL' checkbox..."
# open ~/Applications/EasySIMBL.app

brew cask install iterm2 # Terminal alternative
# brew cask install mou # Markdown Editor
# brew cask install google-chrome # Browser
brew cask install slack # Messaging
brew cask install adium # Chat client
brew cask install java
brew install gradle # Java build tool like maven
brew cask install mysqlworkbench
brew cask install github # Github ui client
brew cask install sequel-pro # Sql workbench
brew cask install tableplus # another sql workbench (also supports REDIS!!)
brew cask install datagrip # Jetbrains' take on sql workbench
brew cask install teamsql # Electron app for collaborative sql editing
brew cask install atom # Editor
brew cask install visual-studio-code
brew cask install jewelrybox # RVM UI
brew cask install cocoarestclient
brew cask install macdown # Another Markdown editor
brew cask install skype
brew cask install virtualbox
brew cask install imageoptim # Image Optimizer
brew cask install licecap # Record animated gifs
brew cask install gimp # image manipulation
brew cask install onyx # OS X maintenance and power tools
# brew cask install secrets # OS X settings panel
brew cask install firefox
brew cask install spectacle # manage windows and their positions
brew cask install cakebrew # Brew UI client
brew cask install fontforge
brew cask install blender # i like modelling and do papercraft stuff.
brew cask install steam # i am a gamer
brew cask install vlc
## Commercial Cask Applications (may work as trial)
# brew cask install sublime-text3
brew cask install tower # tower2 git ui client
brew cask install versions # svn ui client
brew cask install libreoffice # productivity stuff you cannot without
# brew install Caskroom/cask/kitematic # Docker
brew cask install disk-inventory-x # file system overview
brew cask install dbvisualizer
brew cask install sourcetree # another git client
# brew cask install rdm # redis ui client
brew cask install clipy # A Clipboard extension
brew cask install tunnelblick # A VPN Client
brew cask install postman
brew cask install servpane # convenient way to start/stop brew services from menubar
brew cask install inkscape
brew cask install fantastical # iCal alternative
brew cask install gitkraken # some git ui
brew cask install deltawalker # diff/merge ui tool
brew cask install beyond-compare # diff/merge ui tool
brew cask install kaleidoscope # diff/merge ui tool
brew cask install insomnia # REST ui Testing tool
brew cask install soapui # REST ui Testing workbench
brew cask install paw # api tool
brew cask install vyprvpn
brew cask install kite # weird community autocomplete

# Quicklook plugins
brew cask install qlmarkdown # markdown
brew cask install quicklook-json

echo "Cleaning Brews..."
brew cleanup

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
