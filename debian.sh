#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

sudo apt install kitty zsh ranger ncdu tldr curl -y

# install brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install brave-browser -y

ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

# install powerlevel10k zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.powerlevel10k
echo 'source $HOME/.powerlevel10k/powerlevel10k.zsh-theme' >> $HOME/.zshrc

# install fonts for powerlevel10k
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o "$HOME/Downloads/MesloLGS NF Regular.ttf"
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o "$HOME/Downloads/MesloLGS NF Bold.ttf"
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o "$HOME/Downloads/MesloLGS NF Italic.ttf"
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o "$HOME/Downloads/MesloLGS NF Bold Italic.ttf"
sudo cp $HOME/Downloads/*.ttf /usr/share/fonts

# set kitty to use said fonts
mkdir -p $HOME/.config/kitty
echo "font_family MesloLGS NF" >> $HOME/.config/kitty/kitty.conf

# set zsh aliases
echo "alias rr='ranger'" >> $HOME/.zshrc
echo "alias rd='source ranger'" >> $HOME/.zshrc
echo "alias py='python3'" >> $HOME/.zshrc
echo "alias la='ls -lA --color'" >> $HOME/.zshrc

# install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh-autosuggestions
echo "source $HOME/.zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh-syntax-highlighting
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc

# set wallpaper
## LXQT
if [ -f "/usr/bin/pcmanfm-qt" ]; then
	pcmanfm-qt --set-wallpaper="$HOME/.dotfiles/wallpapers/cloudy-digital-art-landscape.jpeg"
fi

chsh -s /usr/bin/zsh
