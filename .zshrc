# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_BATTERY_ALWAYS_SHOW=false
# --- Plugins
plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions)

# --- Source 
source $ZSH
source ${HOME}/.dotfiles/.exports
source ${HOME}/.dotfiles/.functions
source ${HOME}/.dotfiles/.aliases
PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; 
    then  eval "$(pyenv init -)"
fi

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
