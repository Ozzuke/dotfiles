# Dotfiles

A clean, organized dotfiles repository using XDG Base Directory specification and intelligent linking.

## Structure

```
.dotfiles/
├── home/                 # Files that go directly to $HOME
│   └── .zshenv           # XDG environment setup
├── config/               # Files that go to $XDG_CONFIG_HOME (~/.config)
│   ├── zsh/              # Zsh configuration
│   │   ├── .zshrc        # Main zsh config
│   │   ├── .p10k.zsh     # Powerlevel10k theme config
│   │   └── .zshrc.d/     # Modular zsh configs
│   │       ├── alias.zsh
│   │       ├── conf.zsh
│   │       ├── env.zsh
│   │       ├── functions.zsh
│   │       └── homebrew.zsh
│   └── git/
│       └── config        # Git configuration
├── scripts/              # Setup and utility scripts
│   ├── homebrew.sh       # Homebrew and app installation
│   ├── defaults.sh       # macOS system preferences
│   └── link-dotfiles.sh  # Intelligent dotfile linking
├── fonts/                # Font files for installation
├── wallpapers/           # Desktop wallpapers
├── iterm2/               # iTerm2 configurations
├── macos.sh              # Main macOS setup orchestrator
└── debian.sh             # Debian/Ubuntu setup script
```

## Features

### Intelligent Linking
- **Interactive conflict resolution**: Prompts for each conflict with options to overwrite, skip, or apply to all
- **XDG compliance**: Organizes configs properly in `~/.config`
- **Legacy compatibility**: Creates traditional home directory links for compatibility
- **Summary reporting**: Shows what was linked, skipped, or failed

### Organized Structure
- **home/**: Files that should be linked directly to `$HOME`
- **config/**: Directories that map to `$XDG_CONFIG_HOME` subdirectories
- **Flexible**: Easy to add new applications by creating subdirectories in `config/`

### Location Agnostic
- Scripts auto-detect the dotfiles directory location
- Works whether dotfiles are in `.dotfiles`, `.config/dots`, or anywhere else
- All paths calculated dynamically

## Quick Start

### macOS Complete Setup
```bash
git clone https://github.com/Ozzuke/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./macos.sh
```

### Individual Components
```bash
# Just install apps
./scripts/homebrew.sh

# Just apply system defaults
./scripts/defaults.sh

# Just link dotfiles
./scripts/link-dotfiles.sh
```

## Setup Options

The main `macos.sh` script offers several setup modes:

1. **Complete setup** (default) - Homebrew + System defaults + Dotfiles
2. **Homebrew and apps only** - Just software installation
3. **System defaults only** - Just macOS preferences
4. **Dotfiles setup only** - Just link configuration files

## Homebrew Installation

Choose between two app suites:

- **Light suite** (default): Essential daily-use applications
- **Heavy suite**: Includes professional/development tools (Unity, Microsoft Office, Adobe Creative Cloud, etc.)

The script automatically:
- Installs Homebrew if not present
- Sets up proper environment in zsh configuration
- Installs command-line tools and applications
- Provides timeout-based defaults for automation

## Adding New Configurations

### For Home Directory Files
```bash
# Add file to home/ directory
echo "export EDITOR=vim" > home/.profile

# Run linking script
./scripts/link-dotfiles.sh
```

### For Config Files
```bash
# Create application config directory
mkdir -p config/nvim

# Add config files
echo "set number" > config/nvim/init.vim

# Run linking script
./scripts/link-dotfiles.sh
```

The linking script will automatically:
- Create `~/.config/nvim/init.vim`
- Handle any conflicts interactively
- Report the results

## XDG Base Directory Compliance

This setup follows the XDG Base Directory specification:

- **XDG_CONFIG_HOME**: `~/.config` (configuration files)
- **XDG_DATA_HOME**: `~/.local/share` (application data)
- **XDG_CACHE_HOME**: `~/.cache` (cached data)

Applications that support XDG will automatically use the correct directories. For applications that don't, legacy compatibility links are created.

## Zsh Configuration

The zsh configuration is modular and organized:

- **config/zsh/.zshrc**: Main configuration file
- **config/zsh/.zshrc.d/**: Modular configuration files
  - `alias.zsh`: Command aliases
  - `conf.zsh`: General configuration
  - `env.zsh`: Environment variables
  - `functions.zsh`: Custom functions
  - `homebrew.zsh`: Homebrew environment setup

## Legacy Application Support

For applications that don't support XDG directories, compatibility links are automatically created:

- `~/.zshrc` → `~/.config/zsh/.zshrc`
- `~/.gitconfig` → `~/.config/git/config`
- `~/.p10k.zsh` → `~/.config/zsh/.p10k.zsh`

## Conflict Resolution

The linking script provides interactive conflict resolution:

- **Per-file decisions**: Choose to overwrite or skip individual files
- **Batch operations**: Apply the same action to all future conflicts
- **Safe operations**: Never overwrites without permission
- **Detailed reporting**: Summary of all linking operations

## Requirements

- macOS (for macOS-specific features)
- Bash 4.0+ (for advanced scripting features)
- Git (for cloning the repository)

## License

This dotfiles configuration is open source and available under standard dotfiles conventions.