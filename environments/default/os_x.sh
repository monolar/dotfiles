#!/usr/bin/env bash

PROG=${0##*/}

# OS X Yosemite+ only...
#if ! [[ $(sw_vers -productVersion) =~ ^10\.11.\..+ ]]; then
#  echo "$PROG script is intended only for OS X versions 10.10.0 and up"
#  exit 1
#fi

# Configuring OS X Settings
echo "Configuring OS X"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## General

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set computer name
sudo scutil --set ComputerName "M"
sudo scutil --set HostName "M"
sudo scutil --set LocalHostName "M"

# Set standby to 24h
sudo pmset -a standbydelay 86400

## UI

# Set Dark Theme
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# CTRL+Command+option - T switches dark mode on/off
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true

# Set Highlight Color
defaults write "Apple Global Domain" AppleHighlightColor "1.000000 0.874510 0.701961" 

## Dock

# Reduce transparency in OS X.
defaults write com.apple.universalaccess reduceTransparency -boolean true

## Desktop & ScreenSaver

# Disable shadows on screen captures (default: not set).
defaults write com.apple.screencapture disable-shadow -boolean true

##################################
## Mouse / Keyboard / Scrolling ##
##################################

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

############
## Finder ##

# New windows show home directory.
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Enable text selection in Quick Look (default: not set).
defaults write com.apple.finder QLEnableTextSelection -boolean true

# Show icons on the desktop for external disks.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -boolean true

# Show icons on the desktop for removable media.
defaults write com.apple.finder ShowRemovableMediaOnDesktop -boolean true

# Show status bar.
defaults write com.apple.finder ShowStatusBar -boolean true

## Misc Settings

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "You may need to at least log out and log in again for changes to take effect!"
