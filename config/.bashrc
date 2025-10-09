alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias v='nvim'
alias ll='ls -lha'
alias s='source'
alias yz='yazi'

nixshot() {
  nix-shell -p $1 --run $1
}

# Utility
mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xvf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Add this to your shell profile
export LD_LIBRARY_PATH="/run/current-system/sw/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/.cargo/bin/:/usr/local/bin/:$PATH"
export PS1='\[\e[38;5;76m\]\u\[\e[0m\]@\[\e[38;5;214m\]\h\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
