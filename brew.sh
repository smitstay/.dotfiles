#!/usr/bin/env bash

# Update Homebrew (Cask) & packages
brew update
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# shell components
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# apps
brew install pyenv
brew install node
brew cask install clipy
brew cask install docker
brew cask install iterm2
brew cask install postman
brew cask install visual-studio-code
brew cask install spotify
brew cask install intellij-idea

# Remove outdated versions from the cellar.
brew cleanup
