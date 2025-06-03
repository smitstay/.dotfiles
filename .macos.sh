#!/usr/bin/env bash
# ~/.macos.sh
# Run this file once (or re-run after an OS update) to apply macOS defaults.

echo "Applying macOS system defaults…"

# 1) Speed up window resize animations and auto-hide Dock
defaults write NSGlobalDomain NSWindowResizeTime -float 0.003
defaults write com.apple.dock autohide -bool true

# 2) Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# 3) Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 4) Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# 5) Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# 6) Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# 7) Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# 8) Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# 9) Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# 10) Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# 11) Set fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Restart affected apps so changes take effect
killall Finder &> /dev/null || true
killall Dock &> /dev/null || true
killall SystemUIServer &> /dev/null || true

echo "macOS defaults applied."