#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

echo ""
echo "What would you like to set up?"
echo "1) Complete setup (new machines)"
echo "2) Homebrew and apps only"
echo "3) System defaults only"
echo "4) Dotfiles setup only"
echo ""
read -p "Choose an option (1-4, default: 1): " -t 30 setup_choice

# Default to option 1 if no input or timeout
if [[ -z "$setup_choice" ]]; then
    setup_choice=1
    echo "1"
    echo "No selection made, defaulting to complete setup..."
fi

case $setup_choice in
    1)
        echo "Starting complete setup..."
        "$SCRIPT_DIR/scripts/homebrew.sh"
        "$SCRIPT_DIR/scripts/defaults.sh"
        "$SCRIPT_DIR/scripts/link-dotfiles.sh"
        ;;
    2)
        echo "Installing Homebrew and apps..."
        "$SCRIPT_DIR/scripts/homebrew.sh"
        ;;
    3)
        echo "Applying system defaults..."
        "$SCRIPT_DIR/scripts/defaults.sh"
        ;;
    4)
        echo "Setting up dotfiles..."
        "$SCRIPT_DIR/scripts/link-dotfiles.sh"
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

echo ""
echo "Setup complete! Restart the computer to ensure all changes take effect."