# macOS-specific configuration
# This file is sourced only on macOS systems

# iTerm2 shell integration
if [[ -r "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# macOS-specific aliases  
alias la='ls -lAh'  # macOS ls doesn't have --color=auto

# macOS-specific PATH additions
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"