# ~/.zshrc

# Path to Zinit:
export ZINIT_HOME="${HOME}/.zinit"

# Load Zinit
source "${ZINIT_HOME}/bin/zinit.zsh"

# Use Zinit to load Powerlevel10k and essential plugins
# Delegated to .zinitrc for clarity (sourced below)
[[ -f "${HOME}/.zinitrc" ]] && source "${HOME}/.zinitrc"

# ** pyenv initialization **
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# ** nvm initialization **
export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  # Homebrew’s nvm
  . "/opt/homebrew/opt/nvm/nvm.sh"
  . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

# ** Prompt Theme **
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"

# ** Aliases & Utilities **
# You can add any global aliases here. For example:
alias ll="ls -lah"
alias gs="git status"
alias k="kubectl"
alias d="docker"

# ** PATH Customization **
# e.g. add ~/.local/bin or any other custom bins
export PATH="$HOME/.local/bin:$PATH"

# ** Ensure we use the correct Python / Node version per directory **
# If a .python-version or .nvmrc is present, they will be picked up by pyenv and nvm automatically.

# ** Fallback: start zsh in interactive mode **
if [[ $- != *i* ]]; then
  return
fi