#!/usr/bin/env bash

# Update system and install necessary tools
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

# Define APT packages
sudo apt install stow figlet lynis gawk curl wget git alacritty powerline* nala fastfetch net-tools forensics-all cpufetch btop gnome-shell-extension-manager flatpak gnome-software-plugin-flatpak gh lolcat fd-find sd npm vlc build-essential procps file net-tools httpie mitmproxy gpaste-2 font-manager gdebi ufw gawk cmake plocate bat most libssl-dev libvips-dev libsixel-dev libchafa-dev libtbb-dev -y


# Install Oh My Bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"


# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >> $HOME/.bashrc &&

# Define Homebrew packages
brew install gcc dust dog eza zellij neovim xh yazi ffmpegthumbnailer unar jq poppler fd ripgrep zoxide tlrc


# Install ble.sh
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git &&
    make -C ble.sh install PREFIX=~/.local &&
    echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc


# Pull git repo
    git clone https://github.com/st3f4nh4ck/.dotfiles.git $HOME/.dotfiles &&
    rm -rf $HOME/.bashrc &&
    stow $HOME/.dotfiles .

# Install GDM Settings
sudo flatpak install -y io.github.realmazharhussain.GdmSettings org.onlyoffice.desktopeditors org.gnome.World.PikaBackup io.gitlab.zehkira.Monophony io.github.mimbrero.WhatsAppDesktop org.chromium.Chromium org.gnome.Solanum org.qbittorrent.qBittorrent io.github.hvdwofl.jExifToolGUI com.belmoussaoui.Obfuscate net.sourceforge.Pdfedit


# Install Snap Store
    sudo apt install snapd -y &&
    sudo snap install core &&
    sudo snap install snap-store &&
    sudo snap install csbooks

# Install VirtualBox
    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg &&
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list &&
    sudo apt update &&
    sudo apt install virtualbox-7.0 -y

# Install VBox Guest Extension
    vbox_version=$(vboxmanage -v | cut -dr -f1) &&
    wget https://download.virtualbox.org/virtualbox/$vbox_version/Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack &&
    sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack &&
    vboxmanage list extpacks &&
    sudo usermod -aG vboxusers $USER

# Download fonts & install themes
    cd $HOME/Downloads &&
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip &&
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/NerdFontsSymbols.zip &&
    git clone https://github.com/vinceliuice/Tela-icon-theme.git &&
    cd Tela-icon-theme &&
    ./install.sh &&
    cd $HOME/Downloads &&
    git clone https://github.com/vinceliuice/Orchis-theme.git &&
    cd Orchis-theme &&
    ./install.sh --tweaks macos

# Update PATH
echo 'export PATH=$PATH:/opt' >> $HOME/.bashrc

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Upgrade system with nala
sudo nala upgrade

# Display message
figlet "The Machine is Ready."

