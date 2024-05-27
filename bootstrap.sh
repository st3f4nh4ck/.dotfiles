#!/usr/bin/env  bash

# Configuration
CONFIG_DIR="$HOME/.dotfiles/.config"
APT_PACKAGES="stow lynis gawk curl wget git alacritty powerline* nala fastfetch net-tools forensics-all cpufetch btop gnome-shell-extension-manager flatpak gnome-software-plugin-flatpak gh git lolcat fd-find sd npm vlc build-essential procps file net-tools httpie mitmproxy gpaste-2 font-manager gdebi ufw gawk cmake plocate bat most libssl-dev libvips-dev libsixel-dev libchafa-dev libtbb-dev"
HOMEBREW_PACKAGES="gcc dust dog eza zellij neovim xh yazi ffmpegthumbnailer unar jq poppler fd ripgrep zoxide"

# Function to install apt packages
install_apt_packages() {
	sudo apt update
	sudo apt install -y "$APT_PACKAGES"
}

# Function to install Homebrew packages
install_homebrew_packages() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>$HOME/.bashrc
	brew install $HOMEBREW_PACKAGES
}
# Function to install oh-my-bash
install_oh_my_bash() {
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

# Function to install ble.sh
install_ble_sh() {
	git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
	make -C ble.sh install PREFIX=~/.local
	echo 'source ~/.local/share/blesh/ble.sh' >>~/.bashrc
}

# Function to pull git repo                                                                  
install_repo() {                                                                              
  git clone https://github.com/st3f4nh4ck/.dotfiles.git > $HOME
  rm -rf $HOME/.bashrc
  stow $HOME/.dotfiles .

}                                                                                               }

# Function to install GDM Settings to change login wallpaper
install_gdm_settings() {
	flatpak install io.github.realmazharhussain.GdmSettings org.onlyoffice.desktopeditors org.gnome.World.PikaBackup io.gitlab.zehkira.Monophony io.github.mimbrero.WhatsAppDesktop org.chromium.Chromium org.gnome.Solanum org.qbittorrent.qBittorrent io.github.hvdwofl.jExifToolGUI com.belmoussaoui.Obfuscate net.sourceforge.Pdfedit
}

# Function to install Snap Store
install_snap_store() {
	sudo apt install snapd -y
	sudo snap install core && sudo snap install snap-store && sudo snap install csbooks
}

# Function to install VirtualBox
install_virtualbox() {
	wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
	sudo apt update
	sudo apt install virtualbox-7.0 -y
}

# Function to install VBox Guest Extension
install_vbox_guest_extension() {
	vbox_version=$(vboxmanage -v | cut -dr -f1)
	wget https://download.virtualbox.org/virtualbox/$vbox_version/Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack
	sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-$vbox_version.vbox-extpack
	vboxmanage list extpacks
	sudo usermod -aG vboxusers $USER
}

# Function to install cht.sh
install_cht_sh() {
	sudo curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
	sudo chmod +x /usr/local/bin/cht.sh
}

# Function to install themes
install_themes() {
	cd $HOME/Downloads
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip

	git clone https://github.com/vinceliuice/Tela-icon-theme.git
	cd Tela-icon-theme
	./install.sh
	cd $HOME/Downloads ; 	git clone https://github.com/vinceliuice/Orchis-theme.git
	cd Orchis-theme ; 	./install.sh --tweaks macos
}

# Function to remove bloatware
remove_bloat() {
	sudo apt purge gnome-games transmission libreoffice* -y && sudo apt autoremove -y && sudo apt autoclean -y
}

# Perform installations
remove_bloat
install_apt_packages
install_oh_my_bash
install_homebrew_packages
install_ble_sh
install_repo
install_flatpak
install_gdm_settings
install_snap_store
install_virtualbox
install_vbox_guest_extension
install_cht_sh
install_themes

echo 'export PATH=$PATH:/usr/sbin:/usr/local/bin:/opt' >>$HOME/.bashrc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


sudo nala upgrade
echo "Setup completed."
