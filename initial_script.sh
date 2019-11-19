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
printf -- '\033[32m Adding Typora repository...  \033[0m\n';
printf -- '\n';
#Adding Typora Repo
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
echo -e "\ndeb https://typora.io/linux ./" | sudo tee -a /etc/apt/sources.list

printf -- '\n';
printf -- '\033[32m Upgrading and installing packages...  \033[0m\n';
printf -- '\n';
# Other stuff
sudo apt update && sudo apt upgrade -y
sudo apt install zsh zsh-syntax-highlighting tmux vim neovim git openvpn network-manager-openvpn-gnome sublime-text typora flameshot lftp build-essential

printf -- '\n';
printf -- '\033[32m Upgrading and installing packages...  \033[0m\n';
printf -- '\n';
# Other stuff
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y zsh zsh-syntax-highlighting tmux vim neovim git openvpn network-manager-openvpn-gnome sublime-text typora flameshot lftp build-essential


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