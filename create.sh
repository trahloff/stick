#! /bin/bash

# Key for arc-theme
wget -nv http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update

# install tools
sudo apt-get -y install curl git sshuttle

# Git
git config --global user.email "trahloff@deloitte.de"
git config --global user.name "Tobias Rahloff"
sudo apt-get install libgnome-keyring-dev
sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret


# Sources for arc-theme
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"
sudo apt-get update
sudo apt-get install arc-theme

gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'

# install numix icon theme
sudo add-apt-repository -y ppa:numix/ppa
sudo apt-get update
sudo apt-get -y install numix-icon-theme-circle
gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
gsettings set org.gnome.desktop.wm.preferences theme 'Numix'

# install numix cursor
cd ~/Downloads/
git clone https://github.com/numixproject/numix-cursor-theme.git
cp ./numix-cursor-theme/Numix/ /usr/share/icons/Numix
cp ./numix-cursor-theme/Numix-Light/ /usr/share/icons/Numix-Light
sudo update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Numix/cursor.theme 55
sudo update-alternatives --set x-cursor-theme /usr/share/icons/Numix/cursor.theme

# @TODO: install VS Code

# install Postman
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz

sudo mkdir /opt/postman
sudo chmod 777 /opt/postman
sudo tar -xvzf postman.tar.gz -C /opt/postman

sudo cat <<EOF > /usr/share/applications/Postman.desktop
[Desktop Entry]
Name=Postman
Comment=A complete API Development Platform.
GenericName=API Development Platform
Exec=/opt/postman/Postman
Icon=/opt/postman/resources/app/assets/icon.png
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Utility;Development;
MimeType=text/plain;
EOF

# install chromium
sudo apt-get -y install chrome

# install vlc
sudo apt-get -y install vlc

# install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get install -f

# install docker
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce

# set favourites in gnome3
dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'chromium-browser.desktop', 'franz.desktop', 'gnome-terminal.desktop', 'atom.desktop', 'postman.desktop']"

# install fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
chsh -s $(which fish)
curl -L https://get.oh-my.fish | fish
omf install bobthefish
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
sudo apt install fonts-powerline
set -g theme_nerd_fonts yes

# gimme dem reverse incremental searches, baby!
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

# Misc
sudo apt install gnome-tweaks
sudo apt install glances

# CF CLI
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
sudo apt-get update
sudo apt-get install cf-cli
