#! /bin/bash

# Key for arc-theme
wget -nv http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update

# install tools
sudo apt-get -y install aptitude curl git sshuttle

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

# install atom
wget https://atom.io/download/deb -O atom.deb
sudo dpkg -i atom.deb
sudo apt-get install -f
apm install angularjs atom-beautify autocomplete-angular-material block-comment-plus color-picker file-icons git-control highlight-selected jsonlint minimap pigments

# install redshift
sudo apt-get -y install redshift-gtk
# add to autostart
cat <<EOF > ~/.config/autostart/redshift-gtk.desktop
[Desktop Entry]
Type=Application
Exec=redshift-gtk -l 49.4743:8.5347
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=false
Name[de_DE]=redshift
Name=redshift
Comment[de_DE]=
Comment=
EOF

# install Franz
wget https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz -O Franz.tgz
sudo mkdir /opt/franz
sudo chmod 777 /opt/franz
sudo tar -xvzf Franz.tgz -C /opt/franz

sudo cat <<EOF > /usr/share/applications/Franz.desktop
[Desktop Entry]
Name=Franz
Comment=Franz Messenger
GenericName=Franz Client for Linux
Exec=/opt/franz/Franz %U
Icon=/opt/franz/resources/app.asar.unpacked/assets/franz.svg
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Network;InstantMessaging;
MimeType=text/plain;
EOF

# add to autostart
cat <<EOF > ~/.config/autostart/Franz.desktop
[Desktop Entry]
Type=Application
Vestion=1.0
Name=Franz
Comment=Franz startup script
Exec=/home/octavian/franz/Franz
StartupNotify=false
Terminal=false
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[de_DE]=Franz
Comment[de_DE]=Start Franz messenger
EOF

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

# install java
sudo apt-get install -y openjdk-8-jre

# install shutter
sudo apt-get -y install shutter

# add to autostart
cat <<EOF > ~/.config/autostart/Franz.desktop
[Desktop Entry]
Version=1.0
Name=Shutter
Name[de_DE]=Shutter
Name[pt_BR]=Shutter
GenericName=Screenshot Tool
GenericName[de_DE]=Anwendung für Bildschirmfotos
GenericName[pt_BR]=Captura de tela
Comment=Capture, edit and share screenshots
Comment[de_DE]=Bildschirmfotos aufnehmen, bearbeiten und mit Anderen teilen
Comment[pt_BR]=Aplicativo avançado para capturar imagens da tela
Exec=shutter --min_at_startup
Icon=shutter
Terminal=false
Type=Application
Categories=Utility;Application;
X-GNOME-Autostart-enabled=true
Hidden=false
EOF

# install chromium
sudo apt-get -y install chromium-browser

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
sudo apt-get -y install fish
chsh -s $(which fish)

# gimme dem reverse incremental searches, baby!
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install node
git clone https://github.com/creationix/nvm.git ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
