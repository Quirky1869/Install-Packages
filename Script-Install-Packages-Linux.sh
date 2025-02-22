#!/bin/bash

echo "██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗           ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗"
echo "██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║           ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝"
echo "██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗"
echo "██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ╚════╝██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║"
echo "██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗      ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║"
echo "╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝      ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝" 

sleep 3

# Emplacement fichier log
LOG_FILE="/var/log/Script-Install-Packages-Linux.sh.log"

# Déclaration des variables
varDownload="Téléchargements" # If you're computer is in english replace "Téléchargements" with "Downloads"

echo "Debut de l'installation :" 
echo =========================== 

# Mise à jour et upgrade
sudo apt update -y && sudo apt upgrade -y 

# Choix install Visual Studio Code
choixVisualStudioCode=""

while [[ "$choixVisualStudioCode" != "y" && "$choixVisualStudioCode" != "n" ]]; do
echo "Voulez-vous installer Visual Studio Code ? ( y  /  n ) :"
read choixVisualStudioCode

case $choixVisualStudioCode in
    y)  # Si le choix est oui)
        echo Telechargement de Visual Studio Code :
        cd ~/$varDownload
        wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
        echo Installation de Visual Studio Code :
        sudo dpkg -i ./*.deb
        sudo rm ./*deb
        cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Visual Studio Code"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Virtualbox
choixVirtualbox=""

while [[ "$choixVirtualbox" != "y" && "$choixVirtualbox" != "n" ]]; do
echo "Voulez-vous installer Virtualbox ? ( y  /  n ) :"
read choixVirtualbox

case $choixVirtualbox in
    y)  # Si le choix est oui)
        sudo apt install -y virtualbox virtualbox-ext-pack
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Virtualbox"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        sudo apt install -y wireshark
        echo "Ajout de l'utilisateur au groupe "wireshark" :"
        sudo adduser $USER wireshark
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Wireshark"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
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
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer GNS3, ouf !!!" 
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)" 
        ;;
esac
done

# Redirection des log après installation de GNS3 et Wireshark
exec > >(sudo tee -a "$LOG_FILE") 2>&1

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

# Installation des packets
echo Installation des packets 
sudo apt install -y tree wget netcat-traditional htop filezilla zip unzip rar unar unrar net-tools \
    bmon tcptrack nmap whois testdisk tshark git samba gnome-tweaks python3-impacket \
    gnome-disk-utility gparted xournal netdiscover dirb hydra pluma bpytop edb-debugger pip \
    make gnome-shell-extensions rclone rclone-browser dsniff tcpdump libfuse2 pv curl network-manager \
    diodon bat john flameshot binwalk hashcat libimage-exiftool-perl baobab pipx asciinema tmux drawing micro

sudo pip install -U notify-send
python3 -m pip install pwntools
sudo pip install scapy
pip install pycryptodome
pip install mkdocs-material

sudo snap install searchsploit
sudo snap install enum4linux

# recon ng : 
sudo apt install -y git python3-pip
git clone https://github.com/lanmaster53/recon-ng.git
cd recon-ng
pip3 install -r REQUIREMENTS

#Choix install themes
choixThemes=""

while [[ "$choixThemes" != "y" && "$choixThemes" != "n" ]]; do
echo "Voulez-vous installer de nouveaux themes (Icones, curseurs ...) ? ( y  /  n ) :"
read choixThemes

case $choixThemes in
    y)  # Si le choix est oui)
        # Import Theme Terminal
        dconf load /org/gnome/terminal/legacy/profiles:/ < ./Necessary/gnome-terminal-profiles.dconf
	# Export
 	# dconf dump /org/gnome/terminal/legacy/profiles:/ > ./gnome-terminal-profiles.dconf

        # Import Modeles
        cp -r ./Necessary/Nouveaux-documents/* /home/$USER/Modèles 

        # Import Themes
        mkdir /home/$USER/.themes/ 
        cp -r ./Necessary/Themes/* /home/$USER/.themes/ 

        # Import Share Icons
        mkdir /home/$USER/.local/share/icons/ 
        cp -r ./Necessary/Share-Icons/* /home/$USER/.local/share/icons/ 

        # Import Icons / Cursors
        mkdir /home/$USER/.icons/ 
        cp -r ./Necessary/Icons/* /home/$USER/.icons/ 
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer de nouveaux themes"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        cd ~/$varDownload
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        echo Installation de Google Chrome :
        sudo dpkg -i ./*.deb
        sudo rm ./*deb
        cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Google Chrome"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Brave
choixBrave=""

while [[ "$choixBrave" != "y" && "$choixBrave" != "n" ]]; do
echo "Voulez-vous installer Brave ? ( y  /  n ) :"
read choixBrave

case $choixBrave in
    y)  # Si le choix est oui)
        sudo apt install curl -y
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt update -y
        sudo apt install brave-browser -y
        cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Brave"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer Discord"
        cd ~/$varDownload
        wget https://stable.dl2.discordapp.net/apps/linux/0.0.68/discord-0.0.68.deb
        echo Installation de Discord :
	sudo dpkg -i ./*.deb
	sudo rm ./*deb
	cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Discord"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer Apache2"
        sudo apt install -y apache2
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Apache2"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer mariadb"
        sudo apt install -y mariadb-server
#       sudo systemctl status mariadb
##      sudo mysql_secure_installation
## 	    current password for root : enter
## 	    Switch to unix_socket authentication [Y/n] n
## 	    Change the root password? [Y/n] n
## 	    Remove anonymous users? [Y/n] Y
## 	    Disallow root login remotely? [Y/n] Y
## 	    Remove test database and access to it? [Y/n] Y
## 	    Reload privilege tables now? [Y/n] Y
#       sudo mariadb
# 	    USE mysql;
# 	    FLUSH PRIVILEGES;
# 	    ALTER USER 'root'@'localhost' IDENTIFIED BY 'monsupermotdepasse';
# 	    EXIT;
#       sudo systemctl restart mariadb
#       mariadb -u root -p     ou  mysql -u root -p
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer mariadb"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Docker Desktop
# Lien : https://linuxiac.com/how-to-install-docker-on-linux-mint-21/
# Lien : https://docs.docker.com/desktop/install/ubuntu/

# Install one line : curl -sSL https://get.docker.com/ | sh
choixDockerDesktop=""

while [[ "$choixDockerDesktop" != "y" && "$choixDockerDesktop" != "n" ]]; do
echo "Voulez-vous installer Docker / Docker compose / Docker Desktop ? ( y  /  n ) :"
read choixDockerDesktop

case $choixDockerDesktop in
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer Docker / Docker compose / Docker Desktop"
        #sudo apt install -y curl docker-ce-cli pass uidmap
        cd ~/$varDownload
        sudo apt install apt-transport-https ca-certificates curl gnupg
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update -y
        sudo apt install -y docker-ce 
        sudo apt install -y docker-ce-cli
        sudo apt install -y containerd.io
        sudo apt install -y docker-buildx-plugin
        sudo apt install -y docker-compose-plugin
        echo "Etat actuel de Docker"
        sudo systemctl is-active docker
        sleep 5
        #wget https://desktop.docker.com/linux/main/amd64/137060/docker-desktop-4.27.2-amd64.deb
	curl 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64' -o docker-desktop.deb
        sudo apt install ./*.deb
        sudo rm ./*deb
	#sudo snap install docker
        cd
        sudo systemctl restart docker
	sudo adduser $USER docker
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Docker Desktop"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install GitHub Desktop
choixGithubDesktop=""

while [[ "$choixGithubDesktop" != "y" && "$choixGithubDesktop" != "n" ]]; do
echo "Voulez-vous installer GitHub Desktop ? ( y  /  n ) :"
read choixGithubDesktop

case $choixGithubDesktop in
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer GitHub Desktop"
        sudo apt install -y apt-transport-https gnupg2 software-properties-common
        cd ~/$varDownload
        wget https://github.com/shiftkey/desktop/releases/download/release-3.1.7-linux1/GitHubDesktop-linux-3.1.7-linux1.deb
        sudo apt install -f ./GitHubDesktop-linux-3.1.7-linux1.deb
        rm ./*.deb
	cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer GitHub Desktop"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
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
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer NordVPN"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer Obsidian et commencer à configurer rclone"
        mkdir ~/Obsidian_Vault
        wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/obsidian_1.5.12_amd64.deb
        sudo dpkg -i ./*deb
        sudo rm -f ./*deb

        # Copie du script qui permet de synchroniser les fichiers du PC vers Google Drive
        sudo cp -f ./Necessary/Obsidian-rclone/synchro-pc-obsidian-to-google-drive.sh /usr/local/bin
        sudo chmod u+x /usr/local/bin/synchro-pc-obsidian-to-google-drive.sh
        sudo chown $USER:$USER -R /usr/local/bin/synchro-pc-obsidian-to-google-drive.sh

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
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Obsidian"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        echo "Vous avez choisi d'installer Burp Suite"
        cd /home/$USER/Documents
        curl 'https://portswigger-cdn.net/burp/releases/download?product=community&version=2024.3.1.4&type=Linux' -o burpsuite.sh
        chmod +x burpsuite*
        sudo ./burpsuite*
        sudo rm -r burpsuite*
	cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Burp Suite"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
    cd /home/$USER/Documents
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install -y vagrant
        vagrant plugin install vagrant-vbguest
        vagrant --version
	cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Vagrant'"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
    cd /home/$USER/Documents
        sudo apt update
        sudo apt install software-properties-common
        sudo add-apt-repository --yes --update ppa:ansible/ansible
        sudo apt install -y ansible
        ansible --version
	cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Ansible'"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Metasploit
# Lien : https://www.metasploit.com/
choixMetasploit=""

while [[ "$choixMetasploit" != "y" && "$choixMetasploit" != "n" ]]; do
echo "Voulez-vous installer Metasploit ? ( y  /  n ) :"
read choixMetasploit

case $choixMetasploit in
    y)  # Si le choix est oui)
    #cd /home/$USER/Documents
    cd /opt
    sudo apt-get install -y build-essential zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev locate libreadline6-dev libcurl4-openssl-dev git-core autoconf curl postgresql postgresql-contrib libpq-dev libapr1 libaprutil1 libsvn1 libpcap-dev
    sudo git clone https://github.com/rapid7/metasploit-framework.git
    sudo chown $USER:$USER -R metasploit-framework
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

# Choix install The Harvester
# Lien : https://github.com/laramies/theHarvester
# Lien : https://julien.io/retrouver-les-adresses-emails-avec-theharvester/
choixTheHarvester=""

while [[ "$choixTheHarvester" != "y" && "$choixTheHarvester" != "n" ]]; do
echo "Voulez-vous installer The Harvester (OSINT) ? ( y  /  n ) :"
read choixTheHarvester

case $choixTheHarvester in
    y)  # Si le choix est oui)
    cd /opt
    sudo git clone https://github.com/laramies/theHarvester.git
    sudo chown $USER:$USER -R theHarvester # Changement du owner ; si l'option -f est entrée des problèmes ont lieu lors de la génération des fichiers si le owner est root
    cd theHarvester
    python3 -m pip install -r requirements/base.txt
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer TheHarvester'"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Sherlock
# Lien : https://github.com/sherlock-project/sherlock
# Lien : https://www.geeek.org/sherlock-securite-linux/
choixSherlock=""

while [[ "$choixSherlock" != "y" && "$choixSherlock" != "n" ]]; do
echo "Voulez-vous installer Sherlock (OSINT) ? ( y  /  n ) :"
read choixSherlock

case $choixSherlock in
    y)  # Si le choix est oui)
    #cd /opt
    #sudo git clone https://github.com/sherlock-project/sherlock.git
    #sudo chown $USER:$USER -R sherlock # Changement du owner ; sinon à la fin de l'execution des erreurs ont lieu sur les scripts "threading.py", "thread.py", "sherlock.py" (line : 508)
    #chmod +x /opt/sherlock/sherlock/sherlock.py
    #cd sherlock
    #python3 -m pip install -r requirements.txt
    sudo apt install -y pipx
    pipx install sherlock-project
    cd
        ;;
    n)  # Si le choix est non
        echo "Vous avez choisi de ne pas installer Sherlock'"
        ;;
    *)  # Si aucun choix ne correspond
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Holehe
# Lien : https://github.com/megadose/holehe?tab=readme-ov-file
choixHolehe=""

while [[ "$choixHolehe" != "y" && "$choixHolehe" != "n" ]]; do
echo "Voulez-vous installer Holehe (OSINT) ? ( y  /  n ) :"
read choixHolehe

case $choixHolehe in
    y)  # Si le choix est oui)
    	cd /opt
  	sudo git clone https://github.com/megadose/holehe.git
   	sudo chown $USER:$USER -R holehe
	cd holehe/
	sudo python3 setup.py install
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Holehe'"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install SQLmap
# Lien : https://github.com/sqlmapproject/sqlmap
choixSQLmap=""

while [[ "$choixSQLmap" != "y" && "$choixSQLmap" != "n" ]]; do
echo "Voulez-vous installer SQLmap ? ( y  /  n ) :"
read choixSQLmap

case $choixSQLmap in
    y)  # Si le choix est oui)
    	cd /opt
  	sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
   	sudo chown $USER:$USER -R sqlmap-dev
    	sed -i 's|#!/usr/bin/env python|#!/usr/bin/env python3|' /opt/sqlmap-dev/sqlmap.py
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer SQLmap'"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Aperi'solve
# Lien : https://github.com/Zeecka/AperiSolve
choixAperisolve=""

while [[ "$choixAperisolve" != "y" && "$choixAperisolve" != "n" ]]; do
echo "Voulez-vous installer Aperi'solve (STEGANOGRAPHIE) ? ( y  /  n ) :"
read choixAperisolve

case $choixAperisolve in
    y)  # Si le choix est oui)
 	sudo sh -c "$(curl -fs https://www.aperisolve.com/install.sh)"
  	sleep 3
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Aperi'solve"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix install Kitty Terminal
# Lien : https://sw.kovidgoyal.net/kitty/overview/#other-keyboard-shortcuts
choixKittyTerminal=""

while [[ "$choixKittyTerminal" != "y" && "$choixKittyTerminal" != "n" ]]; do
echo "Voulez-vous installer Kitty Terminal ? ( y  /  n ) :"
read choixKittyTerminal

case $choixKittyTerminal in
    y)  # Si le choix est oui)
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/local/bin

    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop

    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

    echo 'kitty.desktop' > ~/.config/xdg-terminals.list

    touch ~/.config/kitty/kitty.conf

cat <<EOF >> ~/.config/kitty/kitty.conf
#### Permet de lancer une application (ici lazydocker) dans un nouvel onglet (tab) ou fenetre (window) ####
map alt+l launch --type=tab lazydocker
#map alt+l launch --type=window lazydocker

#### Permet de gerer l'opacité de la fenetre kitty (ctrl + shift + a puis l ou m) ####
dynamic_background_opacity yes

### Baisse l'opacité du terminal de manière définitive ####
background_opacity 0.95

#### Permet de régler la couleur du background et foreground du terminal ####
# foreground #dddddd
# background #000000

#### Permet de rendre le background flouté ####
# background_blur 0

#### Permet de mettre une image en fond d'écran (PNG/JPEG/WEBP/TIFF/GIF/BMP) ####
# background_image none
# background_image ~/Images/wallpaper.jpg

#### Permet de récupérer les couleurs de .bashrc ou .zshrc (Inutile si un thème est installé) #### 
allow_remote_control yes
term xterm-256color

#### Permet de changer la couleur du texte sélectionné ####
# selection_foreground #000000
# selection_background #fffacd

#### Laisse passer le raccourci ctrl + shift + left ou right ####
map ctrl+shift+left send_text all \x1b[1;6D
map ctrl+shift+right send_text all \x1b[1;6C

#### Permet avec un clic droit de coller ####
mouse_map right press ungrabbed paste_from_clipboard

#### Permet de changer l'emplacement des tab des terminaux (Pour créer :ctrl + shift + t), (Pour fermer ctrl + shift + w) (Valeur possible : top ) ####
#tab_bar_edge top

#### Permet d'afficher le numéro et le titre sur les tab ####
tab_title_template {index}: {title}
#tab_title_template "Onglet {index}"

#### Permet de changer le style de la police dans les tab des terminaux ####
#inactive_tab_font_style normal
#active_tab_font_style   italic

#### Permet de naviguer entre les fenêtres splitter (créer split ctrl + shift + entrée)(Fermer un split ctrl + shift + w) ####
#map shift+alt+Down     next_window
#map shift+alt+Up       previous_window
map ctrl+Down     next_window
map ctrl+Up       previous_window

#### Permet de régler la couleur du curseur ####
# cursor red
# cursor #2a7aef

#### Permet de régler la taille du terminal par défaut ####
# remember_window_size  yes
# initial_window_width  640
# initial_window_height 400
EOF

    cd ~/.config/kitty
    git clone https://github.com/kovidgoyal/kitty-themes.git
    # Commande pour changer de theme -> kitty +kitten themes

    notify-send -i face-wink "Kitty themes" "Commande pour changer de thème : kitty +kitten themes" -t 3000

    # Juste pour info : un theme dracula est disponible
    # https://github.com/dracula/kitty

    # Actions for Nautilus :
    # https://github.com/bassmanitram/actions-for-nautilus
    sudo apt install -y python3-nautilus python3-gi procps libjs-jquery
    git clone https://github.com/bassmanitram/actions-for-nautilus.git
    cd actions-for-nautilus
    make install
    cd ..
    rm -rf actions-for-nautilus
    notify-send -i face-wink "Nouvelle application" "Application installée : actions for nautilus" -t 3000
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Kitty Terminal"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix Lazy Docker
#Lien : https://github.com/jesseduffield/lazydocker
choixLazyDocker=""

while [[ "$choixLazyDocker" != "y" && "$choixLazyDocker" != "n" ]]; do
echo "Voulez-vous installer Lazy Docker ? ( y  /  n ) :"
read choixLazyDocker

case $choixLazyDocker in
    y)  # Si le choix est oui)
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    
    #=============== Mettre kitty en terminal par defaut ==================
    # sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/kitty.app/bin/kitty 50
    # sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 50
    # sudo update-alternatives --config x-terminal-emulator
    # Puis selectionner le terminal kitty
    # gsettings set org.gnome.desktop.default-applications.terminal exec kitty
    # gsettings set org.gnome.desktop.default-applications.terminal exec /home/$USER/.local/kitty.app/bin/kitty

    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Lazy Docker"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix PET
choixPet=""

while [[ "$choixPet" != "y" && "$choixPet" != "n" ]]; do
echo "Voulez-vous installer Pet ? ( y  /  n ) :"
read choixPet

case $choixPet in
    y)  # Si le choix est oui)
    wget https://github.com/knqyf263/pet/releases/download/v1.0.1/pet_1.0.1_linux_amd64.deb
    sudo dpkg -i pet_1.0.1_linux_amd64.deb
    sudo apt update -y && sudo apt install fzf -y
    export EDITOR=micro
    sleep 2
    pet configure
    # pet new
    # pet list
    # pet edit
    # pet search
    # pet exec
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Pet"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)
        echo "Vous avez choisi de copier les fichiers bashrc"
        cp -f ./.bashrc ./.bashrc.ori
        sed -i "s|^\s*alias ll='ls -al'|alias ll='ls -alhF'|" ~/.bashrc
cat << 'EOF' >> ~/.bashrc

### PATH ###
export PATH="/home/$USER/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin"
export PATH="/opt/theHarvester:$PATH"
#export PATH="/opt/sherlock/sherlock:$PATH"   #OLD SHERLOCK
export PATH="/home/$USER/.local/bin:$PATH"    #SHERLOCK
export PATH="/opt/sqlmap-dev:$PATH"

### Encore et encore des alias ###
alias dns="nmcli device show | grep IP4.DNS" # S'appui sur network-manager
alias ipls="netplan status" # S'appui sur iproute2
alias metasploit="msfconsole" # S'appui sur metasploit-framework

alias bat="batcat" # S'appui sur bat
alias logoff="skill -KILL -u $USER" # S'appui sur procps
alias getuser="cut -d: -f1 /etc/passwd" # s'appui sur cut

#alias sherlock="sherlock.py" # S'appui sur sherlock        #OLD SHERLOCK
alias harvester="theHarvester.py" # S'appui sur The Harvester
alias sqlmap="sqlmap.py" # S'appui sur SQLmap
alias ninja="/home/$USER/Public/binaryninja/binaryninja" # S'appui sur Binary Ninja

alias service="systemctl list-units --type=service" # S'appui sur systemctl
alias allservice="systemctl list-units --type=service --all" # S'appui sur systemctl
alias servicesystemd="systemctl list-unit-files" # S'appui sur systemd

alias whatfilemanager="xdg-mime query default inode/directory"
alias whatenvironment="echo $XDG_CURRENT_DESKTOP"
alias pythonserver="sudo python3 -m http.server"

alias lazydocker="/home/$USER/.local/bin/lazydocker" # S'appui sur LazyDocker
EOF

        cp -f ./Necessary/bashrc/.bashrc* /home/$USER/
        notify-send -i face-smile "BashRc" "Les fichiers .bashrc ont été copiés dans /home/$USER" -t 3000
        echo "Vous pouvez faire un : cp -f <.bashrc_voulu> .bashrc"
        source .bashrc
        cp -f ./.bashrc ./.bashrc.ori.with.alias
	cd
        ;;
    n)  # Si le choix est non)
        echo "Vous n'avez pas choisi de copier les fichiers bashrc"
        ;;
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done

# Choix Ninja Binary
choixNinjaBinary=""

while [[ "$choixNinjaBinary" != "y" && "$choixNinjaBinary" != "n" ]]; do
echo "Voulez-vous installer Ninja Binary (Reverse Engineering) ? ( y  /  n ) :"
read choixNinjaBinary

case $choixNinjaBinary in
    y)  # Si le choix est oui)
 	cd ~/Public
    curl https://cdn.binary.ninja/installers/binaryninja_free_linux.zip -o binaryninja.zip
    unzip binaryninja.zip
    sudo rm binaryninja.zip
    cd
        ;;
    n)  # Si le choix est non)
        echo "Vous avez choisi de ne pas installer Ninja Binary"
        ;;
    *)  # Si aucun choix ne correspond)
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
    y)  # Si le choix est oui)

	gsettings set org.gnome.shell.keybindings toggle-message-tray "[]" # Valeur raccourci "Afficher la liste des notifications" supprimé
	
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/']" # Création des emplacements personnalisés des raccourcis claviers

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

        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ name 'Flameshot' # Nom du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ command 'flameshot gui' # Commande du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ binding '<Super><Shift>f' # Raccourci clavier attribué

        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ name 'Kitty' # Nom du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ command 'kitty' # Commande du raccourci
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ binding '<Alt>t' # Raccourci clavier attribué
        
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
    y)  # Si le choix est oui)
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
    n)  # Si le choix est non)
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
    *)  # Si aucun choix ne correspond)
        echo "Ta pas fait le bon choix Maurice (Attention à la casse)"
        ;;
esac
done
