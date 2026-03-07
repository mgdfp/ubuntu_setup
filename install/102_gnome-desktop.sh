#!/bin/bash
set -e
echo "Configuring GNOME Desktop..."

# --- WORKSPACES ---
# Set the number of static workspaces to 6
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# set dark mode.
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# install the papirus-icon-theme package for nicer icons and apply it.
sudo apt install -y papirus-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

echo "GNOME Desktop configured! You may need to log out and back in for all changes to take effect."
