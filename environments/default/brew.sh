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

# TODO brew upgrade --cask
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
brew install --cask google-cloud-sdk
# brew install pyenv-virtualenvwrapper
brew install pipenv
brew install vim --override-system-vi
brew install vimpager
brew install tmux
brew install ranger
brew install htop
brew install pstree
brew install the_silver_searcher # faster search
brew install fd # find alternative (gitignore aware)
brew install fzf # command line fuzzy finder
brew install ctags
brew install stow
brew install mysql@8.0
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
# brew install thefuck
# brew install the_platinum_searcher
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
brew install ripgrep # rust powered grep/ag alternative
brew install lcov
brew install csvkit # nice tools for csv operations
brew install bat # cat for markdown
brew install ghostty # a nice terminal emulator

# install PIL, imagemagick, graphviz and other
# image generating stuff
brew install libtiff
brew install libjpeg
brew install webp
brew install little-cms2

brew install --cask xquartz
brew install imagemagick --with-fftw --with-librsvg --with-x11
brew install cairo

brew install py2cairo # this will ask you to download xquartz and install it
brew install pyqt

# brew install adymo/kde/massif-visualizer # for memory profile visualisation
brew install watchman # watch fs changes
brew install watchexec # watch fs changes (gitignore aware)
brew install memcache-top

# touchbar
brew install --cask pock

# Docker
# brew install docker-machine
# brew install codeclimate
brew install docker
brew install docker-compose

brew install packer # Hashicorps meta-take on building

echo "installing Cask Applications..."
brew install --cask docker

# Java and neo4j
brew install --cask temurin8
brew install neo4j # Graph Database

brew install --cask intellij-idea-ce
brew install --cask pycharm-ce

# brew install Caskroom/cask/easysimbl
# echo "Starting EasySIMBL: Check 'Use SIMBL' checkbox..."
# open ~/Applications/EasySIMBL.app

brew install --cask iterm2 # Terminal alternative
# brew install --cask mou # Markdown Editor
# brew install --cask google-chrome # Browser
brew install --cask slack # Messaging
brew install --cask adium # Chat client
brew install --cask temurin
brew install gradle # Java build tool like maven
brew install --cask mysqlworkbench
brew install --cask github # Github ui client
brew install --cask sequel-ace # Sql workbench
brew install --cask tableplus # another sql workbench (also supports REDIS!!)
brew install --cask datagrip # Jetbrains' take on sql workbench
brew install --cask teamsql # Electron app for collaborative sql editing
brew install --cask atom # Editor
brew install --cask visual-studio-code
brew install --cask jewelrybox # RVM UI
brew install --cask cocoarestclient
brew install --cask macdown # Another Markdown editor
brew install --cask skype
brew install --cask virtualbox
brew install --cask imageoptim # Image Optimizer
brew install --cask licecap # Record animated gifs
brew install --cask gimp # image manipulation
brew install --cask onyx # OS X maintenance and power tools
# brew install --cask secrets # OS X settings panel
brew install --cask firefox
brew install --cask spectacle # manage windows and their positions
brew install --cask fontforge
brew install --cask blender # i like modelling and do papercraft stuff.
brew install --cask steam # i am a gamer
brew install --cask vlc
## Commercial Cask Applications (may work as trial)
# brew install --cask sublime-text3
brew install --cask tower # tower2 git ui client
brew install --cask versions # svn ui client
brew install --cask libreoffice # productivity stuff you cannot without
# brew install Caskroom/cask/kitematic # Docker
brew install --cask disk-inventory-x # file system overview
brew install --cask dbvisualizer
brew install --cask sourcetree # another git client
# brew install --cask rdm # redis ui client
brew install --cask clipy # A Clipboard extension
brew install --cask tunnelblick # A VPN Client
brew install --cask postman
brew install --cask servpane # convenient way to start/stop brew services from menubar
brew install --cask inkscape
brew install --cask fantastical # iCal alternative
brew install --cask gitkraken # some git ui
brew install --cask deltawalker # diff/merge ui tool
brew install --cask beyond-compare # diff/merge ui tool
brew install --cask kaleidoscope # diff/merge ui tool
brew install --cask insomnia # REST ui Testing tool
brew install --cask soapui # REST ui Testing workbench
brew install --cask paw # api tool
brew install --cask vyprvpn
brew install --cask kite # weird community autocomplete
brew install --cask whatsapp # yeah, i know
brew install --cask alacritty # gpu based terminal emulator

# Quicklook plugins
brew install --cask qlmarkdown # markdown
brew install --cask quicklook-json

echo "Cleaning Brews..."
brew cleanup

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
