#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# TODO: Be more defensively

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# XCode sdk
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "checking brew..."
brew doctor

echo "tapping dupes..."
brew tap homebrew/dupes

echo "tapping crystal"
brew tap manastech/crystal

# Make sure we’re using the latest Homebrew.
echo "updating brews..."
brew update

# Upgrade any already-installed formulae.
echo "upgrading brews..."
brew upgrade

# All "normal" brew packages...
echo "... brewing ..."
brew install bash
brew install bash-completion
brew install coreutils
brew install binutils
brew install git --with-brewed-curl --with-brewed-openssl --with-brewed-svn --with-gettext
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
brew install vim --override-system-vi
brew install tmux ranger htop wget the_silver_searcher ctags stow
brew install mysql node tree tig

brew install crystal-lang

# Install brew cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install cask applications
echo "installing Cask Applications..."

brew install Caskroom/cask/easysimbl
echo "Starting EasySIMBL: Check 'Use SIMBL' checkbox..."
open ~/Applications/EasySIMBL.app

brew install Caskroom/cask/iterm2
brew install Caskroom/cask/mou
brew install Caskroom/cask/google-chrome
brew install Caskroom/cask/slack
brew install Caskroom/cask/adium
brew install Caskroom/cask/java
brew install Caskroom/cask/mysqlworkbench
brew install Caskroom/cask/github-desktop
brew install Caskroom/cask/sequel-pro
brew install Caskroom/cask/atom
brew install Caskroom/cask/jewelrybox
brew install Caskroom/cask/cocoarestclient
brew install Caskroom/cask/macdown
brew install Caskroom/cask/skype
brew install Caskroom/cask/virtualbox
brew install Caskroom/cask/imageoptim
brew install Caskroom/cask/licecap
brew install Caskroom/cask/gimp
brew install Caskroom/cask/onyx
brew install Caskroom/cask/secrets
brew install Caskroom/cask/firefox

## Commercial Cask Applications (may work as trial)
brew cask install sublime-text3
brew install Caskroom/cask/tower # installs tower2
brew install Caskroom/cask/sizeup

echo "Cleaning Brews..."
brew cleanup

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
