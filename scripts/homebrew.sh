#!/usr/bin/env bash

echo "Setting up Homebrew and applications..."

# Determine the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Source the apps configuration
source "$DOTFILES_DIR/apps.sh"

###############################################################################
# Installation Process                                                        #
###############################################################################

# Ask for installation type
echo ""
echo "Choose installation type:"
echo "1) Light suite (essential apps only)"
echo "2) Heavy suite (includes professional/development tools)"
echo ""
read -p "Choose suite (1-2, default: 1): " -t 60 suite_choice

# Default to light suite if no input or timeout
if [[ -z "$suite_choice" ]]; then
    suite_choice=1
    echo "1"
    echo "No selection made, defaulting to light suite..."
fi

# Set which apps to install based on choice
case $suite_choice in
    1)
        echo "Installing light suite..."
        APPS_TO_INSTALL=("${LIGHT_CASKS[@]}")
        MAS_APPS_TO_INSTALL=("${LIGHT_MAS_APPS[@]}")
        ;;
    2)
        echo "Installing heavy suite..."
        APPS_TO_INSTALL=("${HEAVY_CASKS[@]}")
        MAS_APPS_TO_INSTALL=("${HEAVY_MAS_APPS[@]}")
        ;;
    *)
        echo "Invalid option, defaulting to light suite"
        APPS_TO_INSTALL=("${LIGHT_CASKS[@]}")
        MAS_APPS_TO_INSTALL=("${LIGHT_MAS_APPS[@]}")
        ;;
esac

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo ""
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session
    # Note: Permanent Homebrew environment setup is handled by .zshrc.d/homebrew.zsh
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    echo "Homebrew installed successfully!"
else
    echo "Homebrew already installed. Updating..."
    brew update
fi

# Add any required taps (if any)
if [[ ${#TAPS[@]} -gt 0 ]]; then
    echo ""
    echo "Adding required taps..."
    for tap in "${TAPS[@]}"; do
        echo "Adding tap: $tap"
        brew tap "$tap" 2>/dev/null || echo "Tap $tap already exists or failed to add"
    done
fi

# Install applications
echo ""
echo "Installing applications..."
for app in "${APPS_TO_INSTALL[@]}"; do
    echo "Installing $app..."
    brew install --cask "$app" 2>/dev/null || echo "$app already installed or failed to install"
done

# Install command line tools
echo ""
echo "Installing command line tools..."
for tool in "${FORMULAE[@]}"; do
    echo "Installing $tool..."
    brew install "$tool" 2>/dev/null || echo "$tool already installed or failed to install"
done

###############################################################################
# Mac App Store Applications                                                  #
###############################################################################

# Install Mac App Store apps using mas
if [[ ${#MAS_APPS_TO_INSTALL[@]} -gt 0 ]]; then
    echo ""
    echo "Installing Mac App Store applications..."
    echo "Note: You must be signed in to the App Store for these to work"
    
    for app_id in "${MAS_APPS_TO_INSTALL[@]}"; do
        echo "Installing App Store app: $app_id"
        if mas install "$app_id" 2>/dev/null; then
            echo "Successfully installed $app_id"
        else
            echo "Failed to install $app_id (may already be installed, unavailable, or not signed in to App Store)"
        fi
    done
else
    echo ""
    echo "No Mac App Store applications to install"
fi

# Clean up
echo ""
echo "Cleaning up..."
brew cleanup

echo ""
echo "Homebrew setup complete!"
echo ""
echo "Manual App Store installations may be needed:"
echo "- Affinity Photo"
echo "- Affinity Designer"
echo "- DigiDoc4"
echo "- Xcode (if not installed via heavy suite)"
echo ""
echo "To install the heavy suite later, run: ./scripts/homebrew.sh"