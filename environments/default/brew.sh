#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# XCode sdk
xcode-select --install

# Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "checking brew..."
brew doctor

echo "tapping dupes..."
brew tap homebrew/dupes

# Make sure we’re using the latest Homebrew.
echo "updating brews..."
brew update

# Upgrade any already-installed formulae.
echo "upgrading brews..."
brew upgrade

# All "normal" brew packages...
echo "... brewing ..."
brew install coreutils
brew install binutils
brew install grep
brew install z
brew install gpg
brew install grc
brew install findutils
brew install reattach-to-user-namespace
brew install tmux

# Install brew cask
brew install caskroom/cask/brew-cask

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

## Commercial Cask Applications (may work as trial)
brew install Caskroom/cask/sublime-text # actually installs sublime text 2 instead of 3
brew install Caskroom/cask/tower # installs tower2
brew install Caskroom/cask/sizeup

echo "Cleaning Brews..."
brew cleanup

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

