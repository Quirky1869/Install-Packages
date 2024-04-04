#!/bin/bash

echo "Debut de l'installation :"
echo ===========================

# Mise à jour et upgrade
sudo apt update -y && sudo apt upgrade -y

# Installation des packets
echo Installation des packets
sudo apt install -y tree wget recon-ng htop filezilla zip unzip rar unar unrar net-tools \
    bmon tcptrack nmap whois wireshark testdisk tshark git samba gnome-tweaks python3-impacket \
    gnome-disk-utility gparted xournal netdiscover dirb hydra netcat pluma bpytop

# Wireshark
echo "Ajout de l'utilisateur au groupe "wireshark" :"
sudo adduser $USER wireshark

# Import Theme Terminal
dconf load /org/gnome/terminal/legacy/profiles:/ < ./Necessary/gnome-terminal-profiles.dconf

# Import Modeles
cp ./Necessary/Nouveaux-documents/* /home/$USER/Modèles

# Import Themes
cp ./Necessary/Themes/* /home/$USER/.themes/

# Import Share Icons
cp ./Necessary/Share-Icons/* /home/$USER/.local/share/icons/

# Import Icons
cp ./Necessary/Icons/* /home/$USER/.icons/

# Choix install Google Chrome
choixGoogleChrome=""

while [[ "$choixGoogleChrome" != "y" && "$choixGoogleChrome" != "n" ]]; do
echo "Voulez-vous installer Google Chrome ? ( y  /  n ) :"
read choixGoogleChrome

case $choixGoogleChrome in
    y )  # Si le choix est oui
        cd ~/Téléchargements
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        echo Installation de Google Chrome :
        sudo dpkg -i ./*.deb
        sudo rm ./*deb
        cd
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer Google Chrome"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Visual Studio Code
choixVisualStudioCode=""

while [[ "$choixVisualStudioCode" != "y" && "$choixVisualStudioCode" != "n" ]]; do
echo "Voulez-vous installer Visual Studio Code ? ( y  /  n ) :"
read choixVisualStudioCode

case $choixVisualStudioCode in
    y )  # Si le choix est oui
        echo Telechargement de Visual Studio Code :
        cd ~/Téléchargements
        wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
        echo Installation de Visual Studio Code :
        sudo dpkg -i ./*.deb
        sudo rm ./*deb
        cd
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer Visual Studio Code"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Discord
choixDiscord=""

while [[ "$choixDiscord" != "y" && "$choixDiscord" != "n" ]]; do
echo "Voulez-vous installer Discord ? ( y  /  n ) :"
read choixDiscord

case $choixDiscord in
    y )  # Si le choix est oui
        echo "Vous avez choisi d'installer Discord"
        cd ~/Téléchargements
        wget https://dl.discordapp.net/apps/linux/0.0.47/discord-0.0.47.deb
        echo Installation de Discord :
	sudo dpkg -i ./*.deb
	sudo rm ./*deb
	cd
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer Discord"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix installation de GNS3
choixGNS3=""

while [[ "$choixGNS3" != "y" && "$choixGNS3" != "n" ]]; do

echo "Voulez-vous installer GNS3 ? ( y / n ) :"
read choixGNS3

case $choixGNS3 in
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer GNS3 à vos risques et périls"
        cd ~/Documents
        sudo add-apt-repository ppa:gns3/ppa
        sudo apt update
        sudo apt install gns3-gui gns3-server libpcap-dev -y
        git clone https://github.com/GNS3/ubridge.git -4
        cd ubridge
        sudo apt install -y gcc-multilib
        make
        sudo make install

        echo "Si vous n'avez pas les VPCs dans GNS3, allez dans ~/Documents et executer le fichier install-dynamips.sh"
        cd ~/Documents
        touch install-dynamips.sh
        echo '#!/bin/bash' >> install-dynamips.sh
        echo 'sudo apt install -y dynamips' >> install-dynamips.sh
        echo 'git clone https://github.com/TolgaBagci/vpcs_0.8-1_amd64.deb.git' >> install-dynamips.sh
        echo 'cd vpcs_0.8-1_amd64.deb' >> install-dynamips.sh
        echo 'sudo dpkg -i vpcs_0.8-1_amd64.deb' >> install-dynamips.sh
        sudo chmod +x install-dynamips.sh
        cd
        ;;
    n)  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer GNS3, ouf !!!"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix installation Apache2
choixApache2=""

while [[ "$choixApache2" != "y" && "$choixApache2" != "n" ]]; do
echo "Voulez-vous installer Apache2 ? ( y /  n ) :"
read choixApache2

case $choixApache2 in
    y )  # Si le choix est oui
        echo "Vous avez choisi d'installer Apache2"
        sudo apt install -y apache2
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer Apache2"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install mariadb
choixmariadb=""

while [[ "$choixmariadb" != "y" && "$choixmariadb" != "n" ]]; do
echo "Voulez-vous installer mariadb ? ( y  /  n ) :"
read choixmariadb

case $choixmariadb in
    y )  # Si le choix est oui
        echo "Vous avez choisi d'installer mariadb"
        sudo apt install -y mariadb-server
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer mariadb"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Docker Desktop
# Lien : https://linuxiac.com/how-to-install-docker-on-linux-mint-21/
# Lien : https://docs.docker.com/desktop/install/ubuntu/
choixDockerDesktop=""

while [[ "$choixDockerDesktop" != "y" && "$choixDockerDesktop" != "n" ]]; do
echo "Voulez-vous installer Docker Desktop ? ( y  /  n ) :"
read choixDockerDesktop

case $choixDockerDesktop in
    y )  # Si le choix est oui
        echo "Vous avez choisi d'installer Docker Desktop"
        #sudo apt install -y curl docker-ce-cli pass uidmap
        cd ~/Téléchargements
        sudo apt install apt-transport-https ca-certificates curl gnupg
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt install -y docker-ce 
        sudo apt install -y docker-ce-cli
        sudo apt install -y containerd.io
        sudo apt install -y docker-buildx-plugin
        sudo apt install -y docker-compose-plugin
        echo "Etat actuel de Docker"
        sudo systemctl is-active docker
        sleep 10
        wget https://desktop.docker.com/linux/main/amd64/137060/docker-desktop-4.27.2-amd64.deb
        sudo apt install ./*.deb
        sudo rm ./*deb
        cd
        sudo systemctl restart docker
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer Docker Desktop"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install DockerEtDockerCompose
# Lien : https://docs.docker.com/engine/install/ubuntu/
# echo "Voulez-vous installer Docker et Docker Compose ? ( y  /  n ) :"
# read choixDockerEtDockerCompose
# 
# case $choixDockerEtDockerCompose in
#     y )  # Si le choix est oui
#         echo "Vous avez choisi d'installer Docker et Docker Compose"
#         sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#         sudo systemctl restart docker
#         ;;
#     n )  # Si le choix est non
#         echo "Vous n'avez pas choisi d'installer Docker et Docker Compose"
#         ;;
#     *)  # Si aucun choix ne correspond
#         echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
#         ;;
# esac

# Choix install GitHub Desktop
choixGithubDesktop=""

while [[ "$choixGithubDesktop" != "y" && "$choixGithubDesktop" != "n" ]]; do
echo "Voulez-vous installer GitHub Desktop ? ( y  /  n ) :"
read choixGithubDesktop

case $choixGithubDesktop in
    y )  # Si le choix est oui
        echo "Vous avez choisi d'installer GitHub Desktop"
        sudo apt install -y apt-transport-https gnupg2 software-properties-common
        cd ~/Téléchargements
        wget https://github.com/shiftkey/desktop/releases/download/release-3.1.7-linux1/GitHubDesktop-linux-3.1.7-linux1.deb
        sudo apt install -f ./GitHubDesktop-linux-3.1.7-linux1.deb
        rm ./*.deb
	cd
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer GitHub Desktop"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install NordVPN
choixNordVPN=""

while [[ "$choixNordVPN" != "y" && "$choixNordVPN" != "n" ]]; do
echo "Voulez-vous installer NordVPN ? ( y  /  n ) :"
read choixNordVPN

case $choixNordVPN in
    y )  # Si le choix est oui
        echo "Vous avez choisi d'installer NordVPN"
        cd ~/Téléchargements
        wget -c https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
        sudo dpkg -i nordvpn-release_1.0.0_all.deb
        sudo apt update
        sudo apt install nordvpn
        sudo usermod -aG nordvpn $USER
        # nordvpn login -> copier coller le lien obtenu dans un browser et se connecter
        # nordvpn countries -> lister les pays disponible
        # nordvpn c Belgium -> se connecter en belgique
        # nordvpn d -> se deconnecter
        sudo rm ./*.deb
	cd
        ;;
    n )  # Si le choix est non
        echo "Vous n'avez pas choisi d'installer NordVPN"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Création des raccourcis clavier
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/']" # Création des emplacements personnalisés des raccourcis claviers

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Discord' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'discord' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Alt>d' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Chrome' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'google-chrome' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Alt>c' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Gestionnaire des tâches' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'gnome-system-monitor' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Primary><Shift>Escape' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'Paramètres' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'gnome-control-center' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Super>i' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ name 'Tweaks' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ command 'gnome-tweaks' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ binding '<Super>t' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ name 'Terminal' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ command 'gnome-terminal' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ binding '<Alt>t' # Raccourci clavier attribué

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ name 'Explorateur de fichiers' # Nom du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ command 'Nautilus' # Commande du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ binding '<Super>e' # Raccourci clavier attribué

# Raccourci claviers non personnalisés
echo "Pensez à configurer les raccourcis clavier non personnalisés"
echo "Capture d'écran -> Effectuer une capture d'écran interactivement -> Maj + Super + S"
echo "Navigation -> Changer de fenêtre directement -> Alt + Tabulation"
echo "Lanceurs -> Dossier Personnel -> Super + E"
echo "Lanceurs -> Lancer un terminal -> Alt + T"
Pause

#Pause
echo Installation terminée la session va se fermer
sleep 3

# Logoff
echo Fermeture de session pour application de tout les paramètres :
sleep 2
pkill -u $USER
# skill -KILL -u $USER