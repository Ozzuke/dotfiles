# Environment Configuration
# This file sets up environment variables and PATH

# Set up XDG directories (in case they're not set by .zshenv)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Load env vars from .env files (home first, then XDG for precedence)
if [[ -f "$HOME/.env" ]]; then
  source "$HOME/.env"
fi

if [[ -f "$XDG_CONFIG_HOME/.env" ]]; then
  source "$XDG_CONFIG_HOME/.env"
fi

# Make user binaries available
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Make JetBrains IDE scripts available
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
