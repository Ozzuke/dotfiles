#!/usr/bin/env bash

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/osvald/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install apps
brew install arduino discord iterm2 malwarebytes messenger obs rectangle spotify surfshark qbittorrent tidal visual-studio-code vlc zoom zotero

# install formulae
brew install bat cowsay fortune htop lolcat ncdu neofetch python ranger speedtest-cli task

# install powerlevel10k for zsh
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

# install from the app store
echo affinity photo, affinity designer, digidoc4
