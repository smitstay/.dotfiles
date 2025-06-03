# ~/.functions.zsh

# Quickly create a directory and cd into it
mkcd() {
  if [ -z "$1" ]; then
    echo "Usage: mkcd <directory-name>"
  else
    mkdir -p "$1" && cd "$1"
  fi
}

# Show a tree‐like listing (requires 'tree' brew package)
treelist() {
  if command -v tree >/dev/null 2>&1; then
    tree -C "$@"
  else
    echo "Install 'tree' (brew install tree) to use treelist"
  fi
}

# Recursively find a file by name
ff() {
  if [ -z "$1" ]; then
    echo "Usage: ff <filename>"
  else
    find . -iname "*$1*" 2>/dev/null
  fi
}

# Extract common archive types
extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <file>"
    return 1
  fi
  case "$1" in
    *.tar.bz2)   tar xjf "$1"   ;;
    *.tar.gz)    tar xzf "$1"   ;;
    *.tar.xz)    tar xJf "$1"   ;;
    *.tar)       tar xf "$1"    ;;
    *.zip)       unzip "$1"     ;;
    *.rar)       unrar x "$1"   ;;
    *.7z)        7z x "$1"      ;;
    *)           echo "Cannot extract '$1' via extract()" ;;
  esac
}

# Open current directory in Finder
cdf() {
  code .
}

# Git branch summary
gb() {
  git branch --all | grep -v HEAD | sed 's/.* //'
}