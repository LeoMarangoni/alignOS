#!/bin/bash
####################################################################################################
# 0. sudo with NOPASSWD
sudo sed -i 's/ALL$/NOPASSWD:ALL/' /etc/sudoers
####################################################################################################
# 1. Upgrade System
sudo apt update -y &&
sudo apt upgrade -y &&
sudo apt dist-upgrade -y
####################################################################################################
# 2. Remove Unwanted Packages
# 2.1. Remove default Browser
sudo apt -y purge epiphany-browser \
               epiphany-browser-data
# 2.2. Taking off the trash
sudo apt autoremove -y
sudo apt autoclean -y
####################################################################################################
# 3. Common Packages
sudo apt -y install software-properties-common \
                 apt-transport-https \
                 git
sudo apt -y install rar unrar zip unzip p7zip-full p7zip-rar
####################################################################################################
# 4. Ops Packages
# 4.1. Terminator
sudo apt -y install terminator
# 4.2. VIM
sudo apt -y install vim
# 4.3. Oh my ZSH
# 4.3.1. Zsh
sudo apt -y install zsh
# 4.3.2. OhMyZSH
sudo sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# 4.3.3. Set defaul
sudo chsh -s /usr/bin/zsh $USER
# 4.3.4. ZSH autoSuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 4.4. Networking
# 4.4.1. Net Tools
sudo apt -y install whois dnsutils net-tools nmap openvpn
# 4.4.2 GUI OpenVPN
sudo apt -y install network-manager-openvpn
sudo restart network-manager
####################################################################################################
# 5. Dev Packages
# 5.1. installing docker
sudo rm /var/lib/apt/lists/* -vf
sudo apt-get update
curl -fsSl https://get.docker.com/ | sh
# 5.2. NodeJS
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt install -y nodejs
# 5.3. Golang
wget https://dl.google.com/go/go1.12.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.12.linux-amd64.tar.gz
# 5.4. vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt -y install code
# 5.5. Firacode
mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
fc-cache -f
####################################################################################################
# 6. Media, Social & Office
# 6.1. LibreOffice
sudo apt -y install libreoffice
# 6.2. VLC
sudo apt -y install vlc browser-plugin-vlc
# 6.3. FireFox
sudo apt -y install firefox
# 6.4. Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt -y install google-chrome-stable
# 6.5. Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt -y install spotify-client
# 6.6. Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.7-amd64.deb
sudo dpkg -i slack-desktop-3.3.7-amd64.deb 
sudo apt -f install -y
rm -f slack-desktop-3.3.7-amd64.deb 
####################################################################################################
# 7. Theming
# 7.1. Elementary Tweak
sudo add-apt-repository ppa:philip.scott/elementary-tweaks
sudo apt -y install elementary-tweaks
# 7.2. wallpapers
sudo apt -y install elementary-wallpapers-extra
# 7.3 OSX Like Theming
# 7.3.1. La Sierra Icons
git clone https://github.com/btd1337/La-Sierra-Icon-Theme ~/.icons/La-Sierra
gsettings set org.gnome.desktop.interface icon-theme "La-Sierra"
# 7.3.2. Cairo Dock
# TODO
# 7.3.3. GTK Sierra Theme
git clone https://github.com/btd1337/eOS-Sierra-Gtk ~/.themes/eOS-Sierra-Gtk
gsettings set org.gnome.desktop.interface gtk-theme 'eOS-Sierra-Gtk'
