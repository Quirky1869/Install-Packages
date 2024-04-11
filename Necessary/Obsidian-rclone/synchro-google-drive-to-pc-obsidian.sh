#!/bin/bash
rclone sync Google-drive:/Obsidian-Google-Drive /home/$USER/Obsidian_Vault/
notify-send -i emblem-shared "Synchro de google drive vers ce PC ok"
