# Homebrew Configuration
# This file sets up Homebrew environment variables and paths

# Only set up Homebrew if it's installed
if [[ -x "/opt/homebrew/bin/brew" ]] || [[ -x "/usr/local/bin/brew" ]]; then
    # Determine Homebrew path based on architecture
    if [[ $(uname -m) == "arm64" ]] && [[ -x "/opt/homebrew/bin/brew" ]]; then
        # Apple Silicon Macs
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        # Intel Macs
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    # Set Homebrew-related environment variables
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    
    # Add common Homebrew paths to PATH if they exist
    if [[ -d "${HOMEBREW_PREFIX}/opt/python/libexec/bin" ]]; then
        export PATH="${HOMEBREW_PREFIX}/opt/python/libexec/bin:${PATH}"
    fi
    
    # Powerlevel10k theme (Homebrew installation)
    if [[ -r "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        source "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"
    fi
    
    # Zsh autocompletion and syntax highlighting
    if [[ -r "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
        source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi
    
    if [[ -r "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
        source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
fi