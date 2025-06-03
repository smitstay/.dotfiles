#!/usr/bin/env bash
set -euo pipefail

# ~/repo/dotfiles/install.sh

#### 1) Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#### 2) Use Brewfile to install packages (including kubectl, pyenv, nvm, k9s, neovim, docker, ghostty, rectangle, maccy, etc.)
if [ -f Brewfile ]; then
  echo "Running brew bundle…"
  brew bundle --file="$PWD/Brewfile"
fi

#### 3) Install Zinit (if not already present)
if [ ! -d "${HOME}/.zinit" ]; then
  echo "Installing Zinit…"
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

#### 4) Install MesloLGS NF font for Powerlevel10k
brew tap homebrew/cask-fonts &>/dev/null
brew install --cask font-meslo-lg-nerd-font

#### 5) Symlink top-level Zsh dotfiles (only if they exist in this repo)
DOTFILES_DIR="$PWD"

declare -A files=(
  [".zshrc"]=".zshrc"
  [".p10k.zsh"]=".p10k.zsh"
  [".zinitrc"]=".zinitrc"
  [".nvmrc"]=".nvmrc"
  [".python-version"]=".python-version"
  [".aliases.zsh"]=".aliases.zsh"
  [".functions.zsh"]=".functions.zsh"
  [".macos.sh"]=".macos.sh"
)

echo "Linking top-level dotfiles…"
for src in "${!files[@]}"; do
  if [ -e "$DOTFILES_DIR/$src" ]; then
    dest="$HOME/${files[$src]}"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "  Backing up existing $dest → $dest.old"
      mv "$dest" "$dest".old
    fi
    echo "  Symlinking $dest ← $DOTFILES_DIR/$src"
    ln -nfs "$DOTFILES_DIR/$src" "$dest"
  else
    echo "  Skipping ${files[$src]} (not present in repo)"
  fi
done

#### 6) Symlink k9s config under ~/.config/k9s/config.yml (if present)
if [ -d "$DOTFILES_DIR/.config/k9s" ] && [ -f "$DOTFILES_DIR/.config/k9s/config.yml" ]; then
  mkdir -p "$HOME/.config/k9s"
  if [ -e "$HOME/.config/k9s/config.yml" ] && [ ! -L "$HOME/.config/k9s/config.yml" ]; then
    echo "  Backing up existing ~/.config/k9s/config.yml → ~/.config/k9s/config.yml.old"
    mv "$HOME/.config/k9s/config.yml" "$HOME/.config/k9s/config.yml.old"
  fi
  echo "  Symlinking ~/.config/k9s/config.yml ← $DOTFILES_DIR/.config/k9s/config.yml"
  ln -nfs "$DOTFILES_DIR/.config/k9s/config.yml" "$HOME/.config/k9s/config.yml"
else
  echo "  Skipping k9s config (repo/.config/k9s/config.yml not found)"
fi

#### 7) Symlink Neovim config under ~/.config/nvim (if present)
if [ -d "$DOTFILES_DIR/.config/nvim" ]; then
  mkdir -p "$HOME/.config"
  if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo "  Backing up existing ~/.config/nvim → ~/.config/nvim.old"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
  fi
  echo "  Symlinking ~/.config/nvim ← $DOTFILES_DIR/.config/nvim"
  ln -nfs "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
else
  echo "  Skipping Neovim config (repo/.config/nvim not found)"
fi

#### 8) Symlink Ghostty config under ~/.config/ghostty/config (if present)
if [ -d "$DOTFILES_DIR/ghostty" ] && [ -f "$DOTFILES_DIR/ghostty/config" ]; then
  mkdir -p "$HOME/.config/ghostty"
  if [ -e "$HOME/.config/ghostty/config" ] && [ ! -L "$HOME/.config/ghostty/config" ]; then
    echo "  Backing up existing ~/.config/ghostty/config → ~/.config/ghostty/config.old"
    mv "$HOME/.config/ghostty/config" "$HOME/.config/ghostty/config.old"
  fi
  echo "  Symlinking ~/.config/ghostty/config ← $DOTFILES_DIR/ghostty/config"
  ln -nfs "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
else
  echo "  Skipping Ghostty config (repo/ghostty/config not found)"
fi

#### 9) Install VSCode extensions (if `code` CLI is available and extensions.list exists)
if command -v code &>/dev/null; then
  if [ -f vscode/extensions.list ]; then
    echo "Installing VSCode extensions…"
    while read -r ext; do
      [ -z "$ext" ] && continue
      echo "  code --install-extension $ext"
      code --install-extension "$ext" || true
    done < vscode/extensions.list
  else
    echo "  Skipping VSCode extension install (vscode/extensions.list not found)"
  fi
else
  echo "  VSCode CLI 'code' not found; skipping extension installs."
fi

#### 10) (Optional) Run macOS defaults if on macOS (Darwin) and ~/.macos.sh exists
if [[ "$(uname)" == "Darwin" ]] && [ -f "$HOME/.macos.sh" ]; then
  echo "Applying macOS defaults via ~/.macos.sh…"
  chmod +x "$HOME/.macos.sh"
  "$HOME/.macos.sh"
fi

echo "Setup complete! Please restart your terminal or run 'exec zsh'."