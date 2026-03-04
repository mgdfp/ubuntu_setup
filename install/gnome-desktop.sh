#!/bin/bash
set -e

echo "Configuring GNOME Desktop..."

# --- WORKSPACES ---
# Set the number of static workspaces to 6
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# Enable workspace numbers in the top bar (requires a GNOME extension or specific shell theme)
# On standard Ubuntu, we can at least ensure the switcher shows them:
gsettings set org.gnome.shell.overrides edge-tiling true

# --- THE DOCK (Dash-to-Dock) ---
# Define exactly which apps you want in the dock (use the .desktop filenames)
# Note: You must use the exact name found in /usr/share/applications/
DOCK_APPS="['google-chrome.desktop', 'code.desktop', 'obsidian.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'whatsapp.desktop']"

gsettings set org.gnome.shell favorite-apps "$DOCK_APPS"

# Additional Dock Tweaks
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false      # Autohide
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32 # Smaller icons
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false   # Floating dock
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize

echo "GNOME Desktop configured! You may need to log out and back in for all changes to take effect."
