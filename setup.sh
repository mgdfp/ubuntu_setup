#!/bin/bash
set -e
sudo -v

echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install -y openssh-server git gitk
sudo systemctl enable --now ssh

sudo apt install curl wget
sudo apt install -y flatpak

# Loop through every script in the 'install' directory
for script in install/*.sh; do
  # Extract just the filename without the .sh extension (e.g., 'vlc')
  app_name=$(basename "$script" .sh)

  # Ask the user
  read -p "Install $app_name? (y/n) " -n 1 -r
  echo

  # If yes, run the script
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "installing $app_name..."
    bash "$script"
    echo "$app_name installed"
  fi
done

echo "Setup complete!"
