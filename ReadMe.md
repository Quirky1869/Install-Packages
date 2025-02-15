![pingouin](./Necessary/Images/Linux.png)

# README

**Veuillez lire tout le readme.md svp**

# Disclaimer

Je ne serai responsable en aucun cas des problèmes rencontrés lors de l'installation des packages sur votre ordinateur que ca soit pendant ou après l'installation. Je vous conseil de lire au complet le script "Script-Install-Packages-Linux.sh", d'une part pour comprendre exactement ce qu'il va faire sur votre ordinateur et d'autre part pour enlever ce que vous ne voulez pas (à vos risques ; soyez sûr de ce que vous faites)

# Introduction

Install-packages est conçus pour pouvoir installer rapidement et facilement plusieurs packages et applications ; idéal sur un nouvel OS fraichement installé

# Informations

- Si votre ordinateur est en anglais il faut changer la variable "varDownload" au début du .sh
- Certaines installation durant le script ont besoin d'une fermeture de session (elle est prévu en fin de script), veuillez effectuer la fermeture de session avant d'essayer un packages, applis ...
- Si vous décider d'installer rclone, les 2 fichiers présent dans "./Necessary/Obsidian-rclone" sont à modifier ; les chemins se nommant "Google-drive:/Obsidian-Google-Drive" et "/home/$USER/Obsidian_Vault/" vous sont personnels, ils dépendent des dossiers de votre pc et des dossiers de votre google-drive
- Un fichier log se nommant `Script-Install-Packages-Linux.sh.log` est créer dans `/var/log/`
- Si vous décider de copier les `.bashrc`, un fichier .bashrc.ori est créé à côté du .bashrc, ils intègrent des petits changements sur le prompt (pour changer de `.bashrc` lancer la commande `cp -f <~/.bashrc_voulu> .bashrc` et relancer le prompt ou lancer un `source ~/.bashrc`) :<br>
1 - Un changement visuel pour chaque `.bashrc_*`<br>
2 - Une modification du $PATH (Ils servent pour les alias)<br>
3 - Des alias :
>- dns
>- ipls
>- bat
>- logoff
>- getuser
>- sherlock (valide **uniquement** si vous avez fait l'installation de sherlock)
>- metasploit (valide **uniquement** si vous avez fait l'installation de metasploit)
>- harvester (valide **uniquement** si vous avez fait l'installation de theHarvester)
>- sqlmap (valide **uniquement** si vous avez fait l'installation de SQLmap)
>- service
>- allservice
>- servicesystemd
>- whatfilemanager
>- whatenvironment
>- ...

- Si vous décider d'installer de nouveaux thèmes il génère un changement visuel du prompt que vous pouvez régler via les préférences de votre prompt ; des curseurs et icones qui sont accessibles via "Tweaks" 

# Etape d'installation

- 1 - Copier le dossier "**Necessary**" et le fichier "**Script-Install-Packages-Linux.sh**" dans votre dossier personnel -> ~ ou /home/$USER

- 1.1 - Lancé un **chmod +x Script-Install-Packages-Linux.sh**

- 2 - Lancer le fichier "**Script-Install-Packages-Linux.sh**" et suivez les instructions

- 3 - Après l'installation lire le memo.txt si besoin

# Version validé

Le script à été testé uniquement sur : 
[Ubuntu 22.04 LTS](https://releases.ubuntu.com/jammy/)

# Problème connu

- Discord et Burpsuite ne sont pas à jour -> Oui je sais, il est possible de devoir faire une update à la mano
