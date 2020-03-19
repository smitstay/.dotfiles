#!/usr/bin/env bash

if which brew > /dev/null; then
    echo "Homebrew is already installed. Skipping.."
else
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


ZSH=~/.oh-my-zsh

if [ -d "$ZSH" ]; then
  echo "Oh My Zsh is already installed. Skipping.."
else
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# plugins
if [ -d "$ZSH/custom/plugins/zsh-autosuggestions" ]; then
    echo "zsh-autosuggestions already installed "
else
    echo "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
fi

if [ -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting already installed "
else
    echo "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
fi

bash brew.sh

# brew needs to install node before running
npm install -g --silent spaceship-prompt

bash .macos

mv ${HOME}/.zshrc ${HOME}/.zshrc-pre-dotfiles
ln -s ${HOME}/.dotfiles/.zshrc ${HOME}

# restart shell for changes to take effect
exec "$SHELL"