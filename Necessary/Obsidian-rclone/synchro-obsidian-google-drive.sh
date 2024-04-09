notify() {
  notify-send -i $1 "Obsidian" "$2"
}

obsync() {
  rclone copy -vv /home/$USER/Obsidian_Vault/ Google-drive:/Obsidian-Google-Drive
 #rclone sync -vv /home/$USER/Obsidian_Vault/ Google-drive:/Obsidian-Google-Drive

  while [[ -n $(jobs -r) ]]; do
    notify $1 "$2"
    sleep 4
  done
}

obsync process-working "Preparing to launch Obsidian..."
obsync drive-harddisk "Synchronizing with Google Drive..."
notify face-wink "Synchro terminée avec succès"
