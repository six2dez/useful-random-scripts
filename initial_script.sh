#!/bin/bash
 cat << "EOF"

###################################################

███████╗██╗██╗  ██╗██████╗ ██████╗ ███████╗███████╗
██╔════╝██║╚██╗██╔╝╚════██╗██╔══██╗██╔════╝╚══███╔╝
███████╗██║ ╚███╔╝  █████╔╝██║  ██║█████╗    ███╔╝ 
╚════██║██║ ██╔██╗ ██╔═══╝ ██║  ██║██╔══╝   ███╔╝  
███████║██║██╔╝ ██╗███████╗██████╔╝███████╗███████╗
╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝╚══════╝

------------------INITIAL SCRIPT-------------------

###################################################

EOF

uname = 'uname -a'
echo $uname

printf -- '\n';
printf -- '\033[32m Change timezone and keyboard layout...  \033[0m\n';
printf -- '\n';
# Change timezone, language and keyboard layout
timedatectl set-timezone Europe/Madrid
L='es' && sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$L'\"/g' /etc/default/keyboard


printf -- '\n';
printf -- '\033[32m Adding SublimeText repository...  \033[0m\n';
printf -- '\n';
#Adding Sublime repo
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

printf -- '\n';
printf -- '\033[32m Upgrading and installing packages...  \033[0m\n';
printf -- '\n';
# Other stuff
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y git zsh zsh-syntax-highlighting tmux vim neovim git openvpn network-manager-openvpn-gnome sublime-text flameshot lftp build-essential curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum sslscan sipvicious tnscmd10g whatweb seclists tor python3 python3-pip unicornscan binwalk ghex exiftool libguestfs-tools pngcheck imagemagick rdesktop


printf -- '\n';
printf -- '\033[32m OhmyZsh...  \033[0m\n';
printf -- '\n';
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

printf -- '\n';
printf -- '\033[32m Installing Hack Nerd Font...  \033[0m\n';
printf -- '\n';
# Installing hack nerd font
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P /usr/share/fonts
fc-cache -fv

printf -- '\n';
printf -- '\033[32m Installing Tilix terminal...  \033[0m\n';
printf -- '\n';
# Tilix no longer in Kali repos
TILIXURL="$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/gnunn1/tilix/releases/latest)"
wget TILIXURL/tilix.zip
sudo unzip tilix.zip -d && sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh

printf -- '\n';
printf -- '\033[32m Installing Git Repos...  \033[0m\n';
printf -- '\n';
mkdir -p $HOME/Repos && cd $HOME/Repos
printf -- '\033[32m AutoRecon...  \033[0m\n';
git clone https://github.com/Tib3rius/AutoRecon && cd AutoRecon
pip3 install -r requirements.txt && cd ..
printf -- '\033[32m My guide...  \033[0m\n';
git clone https://github.com/six2dez/OSCP-Human-Guide && cd ..
printf -- '\033[32m Karma...  \033[0m\n';
git clone https://github.com/decoxviii/karma && cd ..
sudo -H pip3 install git+https://github.com/decoxviii/karma.git --upgrade
printf -- '\033[32m ffuf && golang ...  \033[0m\n';
wget https://golang.org/doc/install?download=go1.13.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
echo 'export GOPATH=/root/go' >> $HOME/.bashrc
echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc
echo 'export GOPATH=/root/go' >> $HOME/.zshrc
echo 'export GOROOT=/usr/local/go' >> $HOME/.zshrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.zshrc
source  $HOME/.bashrc
source  $HOME/.zshrc
go get github.com/ffuf/ffuf
printf -- '\033[32m testssl ...  \033[0m\n';
cd $HOME/Repos
git clone --depth 1 https://github.com/drwetter/testssl.sh.git
printf -- '\033[32m evil-winrm ...  \033[0m\n';
cd $HOME/Repos
git clone https://github.com/Hackplayers/evil-winrm
gem install evil-winrm

printf -- '\n';
printf -- '\033[32m DONE \033[0m\n';
printf -- '\n';
