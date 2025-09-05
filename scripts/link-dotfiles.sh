#!/usr/bin/env bash

###############################################################################
# Dotfiles Linking Script                                                     #
###############################################################################
# This script intelligently links dotfiles from the organized structure:
# - home/     -> Files that go directly to $HOME
# - config/   -> Directories that go to $XDG_CONFIG_HOME
# 
# Features:
# - Interactive prompts for conflicts (no timeout)
# - Summary of unlinked files at the end
# - XDG Base Directory compliance
# - Safe linking with conflict detection

set -euo pipefail

###############################################################################
# Variables and Setup                                                         #
###############################################################################

# Get the directory where this script is located (should be scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the parent directory (the dotfiles repository root)
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo "Dotfiles Linking Script"
echo "======================="
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# Set up XDG directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Arrays to track linking results
declare -a LINKED_FILES=()
declare -a SKIPPED_FILES=()
declare -a FAILED_FILES=()

# Default behavior for conflicts
OVERWRITE_ALL=false
SKIP_ALL=false

###############################################################################
# Helper Functions                                                            #
###############################################################################

# Function to ask user about overwriting files
ask_overwrite() {
    local target="$1"
    local relative_path="$2"
    
    # If user already chose to overwrite/skip all, respect that
    if [[ "$OVERWRITE_ALL" == true ]]; then
        return 0
    elif [[ "$SKIP_ALL" == true ]]; then
        return 1
    fi
    
    echo ""
    echo "Conflict detected:"
    echo "  Target: $target"
    echo "  Source: $relative_path"
    echo ""
    
    # Show target file info
    if [[ -L "$target" ]]; then
        echo "  Existing target is a symlink to: $(readlink "$target")"
    elif [[ -f "$target" ]]; then
        echo "  Existing target is a regular file"
    elif [[ -d "$target" ]]; then
        echo "  Existing target is a directory"
    fi
    
    echo ""
    echo "What would you like to do?"
    echo "  o) Overwrite this file"
    echo "  s) Skip this file"
    echo "  O) Overwrite this and all future conflicts"
    echo "  S) Skip this and all future conflicts"
    echo "  q) Quit"
    echo ""
    
    while true; do
        read -p "Choose an option [o/s/O/S/q]: " choice
        case $choice in
            o|O)
                if [[ "$choice" == "O" ]]; then
                    OVERWRITE_ALL=true
                    echo "Will overwrite all future conflicts automatically"
                fi
                return 0
                ;;
            s|S)
                if [[ "$choice" == "S" ]]; then
                    SKIP_ALL=true
                    echo "Will skip all future conflicts automatically"
                fi
                return 1
                ;;
            q|Q)
                echo "Quitting..."
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter o, s, O, S, or q."
                ;;
        esac
    done
}

# Function to safely create a symlink
safe_link() {
    local source="$1"
    local target="$2"
    local relative_path="$3"
    
    # Create target directory if it doesn't exist
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
    fi
    
    # Check if target already exists
    if [[ -e "$target" || -L "$target" ]]; then
        if ! ask_overwrite "$target" "$relative_path"; then
            SKIPPED_FILES+=("$relative_path -> $target")
            return 1
        fi
        
        # Remove existing file/link
        rm -rf "$target"
    fi
    
    # Create the symlink
    if ln -sf "$source" "$target" 2>/dev/null; then
        LINKED_FILES+=("$relative_path -> $target")
        return 0
    else
        FAILED_FILES+=("$relative_path -> $target (failed to create link)")
        return 1
    fi
}

###############################################################################
# Directory Setup                                                             #
###############################################################################

echo "Setting up XDG directories..."
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME" 
mkdir -p "$XDG_CACHE_HOME"

###############################################################################
# Link Home Directory Files                                                   #
###############################################################################

echo ""
echo "Linking home directory files..."
echo "Looking in: $DOTFILES_DIR/home/"

if [[ -d "$DOTFILES_DIR/home" ]]; then
    # Find all files in the home directory (including hidden files)
    while IFS= read -r -d '' file; do
        # Get relative path from home directory
        relative_path="${file#$DOTFILES_DIR/home/}"
        target="$HOME/$relative_path"
        
        echo "Processing: $relative_path"
        safe_link "$file" "$target" "home/$relative_path"
        
    done < <(find "$DOTFILES_DIR/home" -type f -print0)
else
    echo "No home directory found in dotfiles"
fi

###############################################################################
# Link Config Directory Files                                                 #
###############################################################################

echo ""
echo "Linking config directory files..."
echo "Looking in: $DOTFILES_DIR/config/"

if [[ -d "$DOTFILES_DIR/config" ]]; then
    # Find all files in the config directory
    while IFS= read -r -d '' file; do
        # Get relative path from config directory
        relative_path="${file#$DOTFILES_DIR/config/}"
        target="$XDG_CONFIG_HOME/$relative_path"
        
        echo "Processing: $relative_path"
        safe_link "$file" "$target" "config/$relative_path"
        
    done < <(find "$DOTFILES_DIR/config" -type f -print0)
else
    echo "No config directory found in dotfiles"
fi

###############################################################################
# Legacy Compatibility Links                                                  #
###############################################################################

echo ""
echo "Creating legacy compatibility links..."

# Create legacy links for applications that don't support XDG
declare -A LEGACY_LINKS=(
    ["$XDG_CONFIG_HOME/zsh/.zshrc"]="$HOME/.zshrc"
    ["$XDG_CONFIG_HOME/zsh/.p10k.zsh"]="$HOME/.p10k.zsh"
    ["$XDG_CONFIG_HOME/git/config"]="$HOME/.gitconfig"
)

for xdg_file in "${!LEGACY_LINKS[@]}"; do
    legacy_file="${LEGACY_LINKS[$xdg_file]}"
    
    if [[ -f "$xdg_file" ]]; then
        relative_path="$(basename "$legacy_file") (legacy link)"
        echo "Processing: $relative_path"
        safe_link "$xdg_file" "$legacy_file" "$relative_path"
    fi
done

###############################################################################
# Shell Setup                                                                 #
###############################################################################

echo ""
echo "Setting up shell..."

# Set zsh as default shell if it isn't already
current_shell=$(dscl . -read ~/ UserShell 2>/dev/null | sed 's/UserShell: //' || echo "unknown")
zsh_path=$(which zsh)

if [[ "$current_shell" != "$zsh_path" ]]; then
    echo "Current shell: $current_shell"
    echo "Available zsh: $zsh_path"
    echo ""
    read -p "Change default shell to zsh? [y/N]: " change_shell
    
    if [[ "$change_shell" =~ ^[Yy]$ ]]; then
        if chsh -s "$zsh_path"; then
            echo "Default shell changed to zsh"
            echo "You'll need to restart your terminal or log out/in for the change to take effect"
        else
            echo "Failed to change shell"
        fi
    else
        echo "Keeping current shell"
    fi
else
    echo "zsh is already the default shell"
fi

###############################################################################
# Font Installation                                                           #
###############################################################################

if [[ -d "$DOTFILES_DIR/fonts" ]]; then
    echo ""
    read -p "Install fonts from dotfiles? [y/N]: " install_fonts
    
    if [[ "$install_fonts" =~ ^[Yy]$ ]]; then
        echo "Installing fonts..."
        font_count=0
        skipped_count=0
        
        # Install fonts from subdirectories and root level
        while IFS= read -r -d '' font; do
            if [[ -f "$font" ]]; then
                font_name=$(basename "$font")
                target_path="$HOME/Library/Fonts/$font_name"
                
                # Check if font already exists
                if [[ -f "$target_path" ]]; then
                    echo "Skipping $font_name (already installed)"
                    ((skipped_count++))
                else
                    echo "Installing $font_name..."
                    if cp "$font" "$target_path" 2>/dev/null; then
                        ((font_count++))
                    else
                        echo "Failed to install $font_name"
                    fi
                fi
            fi
        done < <(find "$DOTFILES_DIR/fonts" -type f \( -name "*.ttf" -o -name "*.otf" -o -name "*.ttc" \) -print0)
        
        if [[ $font_count -gt 0 ]]; then
            echo "Installed $font_count new fonts"
            if [[ $skipped_count -gt 0 ]]; then
                echo "Skipped $skipped_count existing fonts"
            fi
            
            # Clear font cache if we have sudo access
            if sudo -n true 2>/dev/null; then
                echo "Clearing font cache..."
                sudo atsutil databases -remove 2>/dev/null || echo "Could not clear font cache"
            else
                echo "Run 'sudo atsutil databases -remove' to clear font cache"
            fi
        elif [[ $skipped_count -gt 0 ]]; then
            echo "All $skipped_count fonts already installed"
        else
            echo "No font files found"
        fi
    fi
else
    echo "No fonts directory found"
fi

###############################################################################
# Summary Report                                                              #
###############################################################################

echo ""
echo "==================="
echo "LINKING SUMMARY"
echo "==================="

if [[ ${#LINKED_FILES[@]} -gt 0 ]]; then
    echo ""
    echo "Successfully linked (${#LINKED_FILES[@]} files):"
    for file in "${LINKED_FILES[@]}"; do
        echo "  ✓ $file"
    done
fi

if [[ ${#SKIPPED_FILES[@]} -gt 0 ]]; then
    echo ""
    echo "Skipped files (${#SKIPPED_FILES[@]} files):"
    for file in "${SKIPPED_FILES[@]}"; do
        echo "  ⊝ $file"
    done
fi

if [[ ${#FAILED_FILES[@]} -gt 0 ]]; then
    echo ""
    echo "Failed to link (${#FAILED_FILES[@]} files):"
    for file in "${FAILED_FILES[@]}"; do
        echo "  ✗ $file"
    done
fi

echo ""
echo "==================="
echo "NEXT STEPS"
echo "==================="
echo ""
echo "• Restart your terminal to load new shell configuration"
echo "• Your dotfiles are organized using XDG Base Directory specification:"
echo "  - Home files: $HOME/"
echo "  - Config files: $XDG_CONFIG_HOME/"
echo "• To re-run this script: $0"
echo ""

if [[ ${#SKIPPED_FILES[@]} -gt 0 ]]; then
    echo "Note: Some files were skipped due to conflicts."
    echo "Re-run this script to handle them differently if needed."
    echo ""
fi