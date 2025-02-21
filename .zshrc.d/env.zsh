# Load env vars from .env file
if [ -f "$HOME/.env" ]; then
  source "$HOME/.env"
fi

# Make user binaries available
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Make JetBrains IDE scripts available
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
