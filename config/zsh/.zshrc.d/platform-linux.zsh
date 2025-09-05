# Linux-specific configuration
# This file is sourced only on Linux systems

# Linux package manager installed plugins
if [[ -r "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -r "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Powerlevel10k theme (manual installation path)
if [[ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Linux-specific aliases
alias la='ls -lAh --color=auto'
alias grep='grep -E --color=auto'