#!/bin/bash
printf -- '\033[32m Cloning w3af repository...  \033[0m\n';
printf -- '\n';
git clone --depth 1 https://github.com/andresriancho/w3af.git
cd w3af/
printf -- '\033[32m Installing console dependecies...  \033[0m\n';
printf -- '\n';
apt install graphviz libssl-dev libxml2 libxslt1.1 libxml2-dev libxslt-dev zlib1g-dev
pip install pybloomfiltermmap==0.3.14
pip install pyopenssl
./w3af_console
bash /tmp/w3af_dependency_install.sh

printf -- '\033[32m Installing gui dependecies...  \033[0m\n';
printf -- '\n';
apt install libicu57 libpango1.0 libegl1-mesa
wget http://ftp.us.debian.org/debian/pool/main/w/webkitgtk/libjavascriptcoregtk-1.0-0_2.4.11-3_amd64.deb 
dpkg -i libjavascriptcoregtk-1.0-0_2.4.11-3_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/w/webkitgtk/libwebkitgtk-1.0-0_2.4.11-3_amd64.deb
dpkg -i libwebkitgtk-1.0-0_2.4.11-3_amd64.deb
dpkg -i python-webkit_1.1.8-3_amd64.deb
bash /tmp/w3af_dependency_install.sh
printf -- '\033[32m Launching w3af_gui!!!! \033[0m\n';
printf -- '\n';
./w3af_gui
# Now should launch w3af_gui woohooo!