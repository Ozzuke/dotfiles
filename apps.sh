# Application Lists Configuration
# This file contains all the applications to be installed via Homebrew and Mac App Store

###############################################################################
# Homebrew Casks (GUI Applications)                                          #
###############################################################################

# Light suite - Essential applications for daily use
LIGHT_CASKS=(
    "android-file-transfer"
    "arc"
    "audacity"
    "balenaetcher"
    "bitwarden"
    "bruno"
    "claude-code" # disable auto update later
    "discord"
    "flux"
    "google-drive"
    "handbrake"
    "iterm2"
    "jetbrains-toolbox"
    "keka"
    "malwarebytes"
    "messenger"
    "obs"
    "obsidian"
    "qbittorrent"
    "rectangle"
    "rustdesk"
    "signal"
    "spotify"
    "sublime-text"
    "surfshark"
    "visual-studio-code"
    "vlc"
    "zoom"
)

# Heavy suite - Professional/Development tools (includes light suite)
HEAVY_CASKS=(
    "${LIGHT_CASKS[@]}"
    "affinity-photo"
    "affinity-designer"
    "affinity-publisher"
    "android-platform-tools"
    "dbeaver-community"
    "unity-hub"
    "warp"
    "whisky"
)

###############################################################################
# Homebrew Formulae (Command Line Tools)                                     #
###############################################################################

# Taps to add before installation (if any are needed in the future)
TAPS=(
    # "some-org/some-tap"  # For some-special-app
)

# Command line tools (same for both suites)
FORMULAE=(
    "bitwarden-cli"
    "cbonsai"
    "cmatrix"
    "cowsay"
    "curl"
    "docker"
    "exiftool"
    "fastfetch"
    "ffmpeg"
    "fzf"
    "gemini-cli"
    "ipython"
    "jq"
    "lolcat"
    "lua"
    "mas"
    "ncdu"
    "nmap"
    "node"
    "openjdk"
    "powerlevel10k"
    "python"
    "ranger"
    "scrcpy"
    "sqlite"
    "tldr"
    "tree"
    "uv"
    "tailscale"
    "wget"
    "yt-dlp"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

###############################################################################
# Mac App Store Applications (using mas)                                     #
###############################################################################

# Light suite - Essential App Store apps
LIGHT_MAS_APPS=(
    "1370791134"  # DigiDoc4
)

# Heavy suite - Professional App Store apps (includes light suite)
HEAVY_MAS_APPS=(
    "${LIGHT_MAS_APPS[@]}"
)