#!/bin/bash

echo "██████╗ ██╗███████╗███╗   ██╗██╗   ██╗███████╗███╗   ██╗██╗   ██╗███████╗"
echo "██╔══██╗██║██╔════╝████╗  ██║██║   ██║██╔════╝████╗  ██║██║   ██║██╔════╝"
echo "██████╔╝██║█████╗  ██╔██╗ ██║██║   ██║█████╗  ██╔██╗ ██║██║   ██║█████╗"  
echo "██╔══██╗██║██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██║╚██╗██║██║   ██║██╔══╝"  
echo "██████╔╝██║███████╗██║ ╚████║ ╚████╔╝ ███████╗██║ ╚████║╚██████╔╝███████╗"
echo "╚═════╝ ╚═╝╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝"

sleep 3

# Emplacement fichier log
LOG_FILE="/var/log/Script-Install-Packages-Linux.sh.log"

# Déclaration des variables
varDownload="Téléchargements" # If you're computer is in english replace "Téléchargements" with "Downloads"

# Fonction pour gérer l'interruption (Ctrl+C)
interrupt_handler() {
    # echo "Suppression du dossier Necessary..."
    # rm -rf "/home/$USER/Necessary"
    echo "Interruption de l'exécution du script par l'utilisateur."
    sleep 3
    exit 1
}

# SIGINT = CTRL + C
trap interrupt_handler SIGINT

echo "Debut de l'installation :" 
echo =========================== 

# Mise à jour et upgrade
sudo apt update -y && sudo apt upgrade -y 

# Choix install Virtualbox
choixVirtualbox=""

while [[ "$choixVirtualbox" != "y" && "$choixVirtualbox" != "n" ]]; do
echo "Voulez-vous installer Virtualbox ? ( y  /  n ) :"
read choixVirtualbox

case $choixVirtualbox in
    y)  # Si le choix est oui
        sudo apt install -y virtualbox virtualbox-ext-pack
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Virtualbox"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Wireshark
choixWireshark=""

while [[ "$choixWireshark" != "y" && "$choixWireshark" != "n" ]]; do
echo "Voulez-vous installer Wireshark ? ( y  /  n ) :"
read choixWireshark

case $choixWireshark in
    y)  # Si le choix est oui
        sudo apt install -y wireshark
        echo "Ajout de l'utilisateur au groupe "wireshark" :"
        sudo adduser $USER wireshark
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Wireshark"
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
        notify-send "Si vous n'avez pas les VPCs dans GNS3, allez dans ~/Documents et executer le fichier install-dynamips.sh" -t 4000
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
        echo "Vous avez choisi de ne pas installer GNS3, ouf !!!" 
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)" 
        ;;
esac
done

# Redirection des log après installation de GNS3 et Wireshark
exec > >(sudo tee -a "$LOG_FILE") 2>&1

# Installation des packets
echo Installation des packets 
sudo apt install -y tree wget recon-ng htop filezilla zip unzip rar unar unrar net-tools \
    bmon tcptrack nmap whois testdisk tshark git samba gnome-tweaks python3-impacket \
    gnome-disk-utility gparted xournal netdiscover dirb hydra netcat pluma bpytop edb-debugger pip \
    make gnome-shell-extensions gpaint rclone rclone-browser dsniff tcpdump libfuse2 pv curl network-manager \
    diodon bat

sudo pip install -U notify-send
python3 -m pip install pwntools


#Choix install themes
choixThemes=""

while [[ "$choixThemes" != "y" && "$choixThemes" != "n" ]]; do
echo "Voulez-vous installer de nouveaux themes (Icones, curseurs ...) ? ( y  /  n ) :"
read choixThemes

case $choixThemes in
    y)  # Si le choix est oui
        # Import Theme Terminal
        dconf load /org/gnome/terminal/legacy/profiles:/ < ./Necessary/gnome-terminal-profiles.dconf 

        # Import Modeles
        cp -r ./Necessary/Nouveaux-documents/* /home/$USER/Modèles 

        # Import Themes
        mkdir /home/$USER/.themes/ 
        cp -r ./Necessary/Themes/* /home/$USER/.themes/ 

        # Import Share Icons
        mkdir /home/$USER/.local/share/icons/ 
        cp -r ./Necessary/Share-Icons/* /home/$USER/.local/share/icons/ 

        # Import Icons
        mkdir /home/$USER/.icons/ 
        cp -r ./Necessary/Icons/* /home/$USER/.icons/ 
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer de nouveaux themes"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Google Chrome
choixGoogleChrome=""

while [[ "$choixGoogleChrome" != "y" && "$choixGoogleChrome" != "n" ]]; do
echo "Voulez-vous installer Google Chrome ? ( y  /  n ) :"
read choixGoogleChrome

case $choixGoogleChrome in
    y)  # Si le choix est oui
        cd ~/$varDownload
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        echo Installation de Google Chrome :
        sudo dpkg -i ./*.deb
        sudo rm ./*deb
        cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Google Chrome"
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
    y)  # Si le choix est oui
        echo Telechargement de Visual Studio Code :
        cd ~/$varDownload
        wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
        echo Installation de Visual Studio Code :
        sudo dpkg -i ./*.deb
        sudo rm ./*deb
        cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Visual Studio Code"
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
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer Discord"
        cd ~/$varDownload
        wget https://dl.discordapp.net/apps/linux/0.0.47/discord-0.0.47.deb
        echo Installation de Discord :
	sudo dpkg -i ./*.deb
	sudo rm ./*deb
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Discord"
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
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer Apache2"
        sudo apt install -y apache2
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Apache2"
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
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer mariadb"
        sudo apt install -y mariadb-server
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer mariadb"
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
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer Docker Desktop"
        #sudo apt install -y curl docker-ce-cli pass uidmap
        cd ~/$varDownload
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
        sleep 5
        wget https://desktop.docker.com/linux/main/amd64/137060/docker-desktop-4.27.2-amd64.deb
        sudo apt install ./*.deb
        sudo rm ./*deb
	sudo snap install docker
        cd
        sudo systemctl restart docker
	sudo adduser $USER docker
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Docker Desktop"
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
#         echo "Vous avez choisi de ne pas installer Docker et Docker Compose"
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
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer GitHub Desktop"
        sudo apt install -y apt-transport-https gnupg2 software-properties-common
        cd ~/$varDownload
        wget https://github.com/shiftkey/desktop/releases/download/release-3.1.7-linux1/GitHubDesktop-linux-3.1.7-linux1.deb
        sudo apt install -f ./GitHubDesktop-linux-3.1.7-linux1.deb
        rm ./*.deb
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer GitHub Desktop"
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
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer NordVPN"
        cd ~/$varDownload
        wget -c https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
        sudo dpkg -i nordvpn-release_1.0.0_all.deb
        sudo apt update
        sudo apt install nordvpn
        sudo usermod -aG nordvpn $USER
        # nordvpn login -> copier coller le lien obtenu dans un browser et se connecter
        # nordvpn countries -> lister les pays disponible
        # nordvpn c Belgium -> se connecter en belgique
        # nordvpn d -> se deconnecter
        sudo rm ./*.deb
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer NordVPN"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Obsidian et début de configuration de rclone
choixObsidian=""

while [[ "$choixObsidian" != "y" && "$choixObsidian" != "n" ]]; do
echo "Voulez-vous installer Obsidian et commencer à configurer rclone ? ( y  /  n ) :"
read choixObsidian

case $choixObsidian in
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer Obsidian et commencer à configurer rclone"
        mkdir ~/Obsidian_Vault
        wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/obsidian_1.5.12_amd64.deb
        sudo dpkg -i ./*deb
        sudo rm -f ./*deb

        # Copie du script qui permet de synchroniser les fichiers du PC vers Google Drive
        sudo cp -f ./Necessary/Obsidian-rclone/synchro-pc-obidian-to-google-drive.sh /usr/local/bin
        sudo chmod u+x /usr/local/bin/synchro-pc-obidian-to-google-drive.sh
        sudo chown $USER:$USER -R /usr/local/bin/synchro-pc-obidian-to-google-drive.sh

        # Copie du script qui permet de synchroniser les fichiers de Google Drive vers le PC
        sudo cp -f ./Necessary/Obsidian-rclone/synchro-google-drive-to-pc-obsidian.sh /usr/local/bin
        sudo chmod +x /usr/local/bin/synchro-google-drive-to-pc-obsidian.sh
        #sudo chown $USER:$USER -R /usr/local/bin/synchro-google-drive-to-pc-obsidian.sh

        # Copie des logos pour Excalidraw
        mkdir /home/$USER/Documents/Excalidraw
        cp -f ./Necessary/Excalidraw/* /home/$USER/Documents/Excalidraw
        notify-send -i dialog-information "Obsidian installé avec succès" "Il faudra finaliser le paramètrage de rclone" -t 2000
	notify-send -i face-wink "Rclone" "Regarder le fichier memo.txt pour configurer rclone" -t 2000
    notify-send "Excalidraw" "Les logos pour Excalidraw sont dans /home/$USER/Documents/Excalidraw" -t 2000
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Obsidian"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Burp Suite
choixBurpSuite=""

while [[ "$choixBurpSuite" != "y" && "$choixBurpSuite" != "n" ]]; do
echo "Voulez-vous installer Burp Suite ? ( y  /  n ) :"
read choixBurpSuite

case $choixBurpSuite in
    y)  # Si le choix est oui
        echo "Vous avez choisi d'installer Burp Suite"
        cd /home/$USER/Documents
        curl 'https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.3.1.4&type=Linux' -o burpsuite.sh
        chmod +x burpsuite*
        sudo ./burpsuite*
        sudo rm -r burpsuite*
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Burp Suite"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Vagrant
choixVagrant=""

while [[ "$choixVagrant" != "y" && "$choixVagrant" != "n" ]]; do
echo "Voulez-vous installer Vagrant ? ( y  /  n ) :"
read choixVagrant

case $choixVagrant in
    y)  # Si le choix est oui
    cd /home/$USER/Documents
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install -y vagrant
        vagrant plugin install vagrant-vbguest
        vagrant --version
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Vagrant'"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Ansible
choixAnsible=""

while [[ "$choixAnsible" != "y" && "$choixAnsible" != "n" ]]; do
echo "Voulez-vous installer Ansible ? ( y  /  n ) :"
read choixAnsible

case $choixAnsible in
    y)  # Si le choix est oui
    cd /home/$USER/Documents
        sudo apt update
        sudo apt install software-properties-common
        sudo add-apt-repository --yes --update ppa:ansible/ansible
        sudo apt install -y ansible
        ansible --version
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Ansible'"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Metasploit
choixMetasploit=""

while [[ "$choixMetasploit" != "y" && "$choixMetasploit" != "n" ]]; do
echo "Voulez-vous installer Metasploit ? ( y  /  n ) :"
read choixMetasploit

case $choixMetasploit in
    y)  # Si le choix est oui
    cd /home/$USER/Documents
    sudo apt-get install -y build-essential zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev locate libreadline6-dev libcurl4-openssl-dev git-core autoconf curl postgresql postgresql-contrib libpq-dev libapr1 libaprutil1 libsvn1 libpcap-dev
	git clone https://github.com/rapid7/metasploit-framework.git
    cd metasploit-framework
    sudo bash -c 'for MSF in $(ls msf*); do ln -s /usr/local/src/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
    sudo service postgresql start
    sudo snap install metasploit-framework
    sudo msfdb init
    msfdb init
    #msfconsole     # Commande pour lancé metasploit
    notify-send "Metasploit" 'Metasploit peut etre lance avec la commande "msfconsole"'
    cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Metasploit'"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix Bashrc
choixBashRc=""

while [[ "$choixBashRc" != "y" && "$choixBashRc" != "n" ]]; do
echo "Voulez-vous copier les fichiers bashrc pour votre terminal ? ( y  /  n ) :"
read choixBashRc

case $choixBashRc in
    y)  # Si le choix est oui
        echo "Vous avez choisi de copier les fichiers bashrc"
        cp -f ./.bashrc ./.bashrc.ori
        cp -f ./Necessary/bashrc/.bashrc* /home/$USER/
        notify-send -i face-smile "BashRc" "Les fichiers .bashrc ont été copiés dans /home/$USER" -t 3000
        echo "Vous pouvez faire un : cp -f <.bashrc_voulu> .bashrc"
        source .bashrc
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous n'avez pas choisi de copier les fichiers bashrc"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix création des raccourcis clavier
choixRaccourcisClavier=""

while [[ "$choixRaccourcisClavier" != "y" && "$choixRaccourcisClavier" != "n" ]]; do
echo "Voulez-vous modifier vos raccourcis clavier ? ( y  /  n ) :"
read choixRaccourcisClavier

case $choixRaccourcisClavier in
    y)  # Si le choix est oui
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/']" # Création des emplacements personnalisés des raccourcis claviers

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

        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ name 'Synchro-Obsidian-Google-Drive' # Nom du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ command 'synchro-obsidian-google-drive.sh' # Commande du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ binding '<Primary><Alt>o' # Raccourci clavier attribué

        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ name 'Diodon' # Nom du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ command '/usr/bin/diodon' # Commande du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ binding '<Super>v' # Raccourci clavier attribué
        
        # Raccourci claviers non personnalisés
        echo "Pensez à configurer les raccourcis clavier non personnalisés"
        echo "Capture d'écran -> Effectuer une capture d'écran interactivement -> Maj + Super + S"
        echo "Navigation -> Changer de fenêtre directement -> Alt + Tabulation"
        echo "Lanceurs -> Dossier Personnel -> Super + E"
        echo "Lanceurs -> Lancer un terminal -> Alt + T"
        sleep 10
	cd
        ;;
    n)  # Si le choix est non
        echo "Vous n'avez pas choisi de ne pas modifier vos raccourcis clavier"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Suppression du dossier "Necessary"
#notify-send "Suppression du dossier Necessary" -t 3000
#rm -rf "/home/$USER/Necessary"
notify-send -i emblem-important "Pensez à supprimer le dossier ~/Necessary" -t 3000

# Pause
echo Installation terminée il faut fermer la session pour appliquer tous les paramètres
notify-send -u critical "Installation terminée il faut fermer la session pour appliquer tous les paramètres" -t 4000
sleep 3

cd
rm .sudo_as_admin_successful

# Choix Logoff
choixLogoff=""

while [[ "$choixLogoff" != "y" && "$choixLogoff" != "n" ]]; do
echo "Voulez-vous fermer la session maintenant ? ( y  /  n ) :"
read choixLogoff

case $choixLogoff in
    y)  # Si le choix est oui
        echo "Vous avez choisi de fermer la session"
        sleep 1
        echo "La session va se fermer dans 5 secondes"
        sleep 1
        echo "La session va se fermer dans 4 secondes"
        sleep 1
        echo "La session va se fermer dans 3 secondes"
        sleep 1
        echo "La session va se fermer dans 2 secondes"
        sleep 1
        echo "La session va se fermer dans 1 seconde"
        sleep 1
        skill -KILL -u $USER
        # pkill -u $USER
        ;;
    n)  # Si le choix est non
        echo "Vous n'avez pas choisi de fermer la session"
        notify-send "Vous n'avez pas choisi de fermer la session" -t 5000
        echo "D'accord BYE !!!"
	    echo "██████╗ ██╗   ██╗███████╗"
        echo "██╔══██╗╚██╗ ██╔╝██╔════╝"
        echo "██████╔╝ ╚████╔╝ █████╗"  
        echo "██╔══██╗  ╚██╔╝  ██╔══╝"  
        echo "██████╔╝   ██║   ███████╗"
        echo "╚═════╝    ╚═╝   ╚══════╝"        
        sleep 4
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done
