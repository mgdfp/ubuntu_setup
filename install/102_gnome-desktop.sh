#!/bin/bash
set -e
echo "Configuring GNOME Desktop..."

# --- WORKSPACES ---
# Set the number of static workspaces to 6
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# 1. Download the extension (v26 is compatible with Ubuntu 24.04/GNOME 46)
cd /tmp
wget -qO space-bar.zip "https://extensions.gnome.org/extension-data/space-barluchrioh.v26.shell-extension.zip"

# 2. Install it to your local extensions folder
gnome-extensions install space-bar.zip --force

# 3. Enable it
gnome-extensions enable space-bar@luchrioh

# 4. Clean up
rm space-bar.zip
cd -

echo "GNOME Desktop configured! You may need to log out and back in for all changes to take effect."
