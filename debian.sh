#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

sudo apt install kitty zsh ranger curl -y

ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

# install powerlevel10k zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# install fonts for powerlevel10k
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o "~/Downloads/MesloLGS NF Regular.ttf"
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o "~/Downloads/MesloLGS NF Bold.ttf"
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o "~/Downloads/MesloLGS NF Italic.ttf"
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o "~/Downloads/MesloLGS NF Bold Italic.ttf"
sudo cp ~/Downloads/*.ttf /usr/share/fonts

# set kitty to use said fonts
mkdir -p ~/.config/kitty
echo "font_family MesloLGS NF" >> ~/.config/kitty/kitty.conf

# set zsh aliases
echo "alias rr=ranger \nalias rd='source ranger' \nalias py=python3 \nalias la='ls -lA --color'" >> ~/.zshrc

# install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
echo "source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
echo "source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# set wallpaper
## LXQT
if [ -f "/usr/bin/pcmanfm-qt" ]; then
	pcmanfm-qt --set-wallpaper="~/.dotfiles/wallpapers/cloudy-digital-art-landscape.jpeg"
fi

chsh -s /usr/bin/zsh
