#!/usr/bin/env bash

PROG=${0##*/}

# OS X Yosemite+ only...
if ! [[ $(sw_vers -productVersion) =~ ^10\.1.\..+ ]]; then
  echo "$PROG script is intended only for OS X versions 10.10.0 and up"
  exit 1
fi

# Configuring OS X Settings
echo "Configuring OS X"

# Ask for the administrator password upfront.
sudo -v

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

## Finder

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

echo "You may need to at least log out and log in again for changes to take effect!"
