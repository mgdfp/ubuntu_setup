#!/bin/bash
set -e

echo "Configuring GNOME Desktop..."

# --- WORKSPACES ---
# Set the number of static workspaces to 6
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# Enable workspace numbers in the top bar (requires a GNOME extension or specific shell theme)
# On standard Ubuntu, we can at least ensure the switcher shows them:
# gsettings set org.gnome.shell.overrides edge-tiling true
# that setting does not exist. get error: No such schema “org.gnome.shell.overrides”
#
#
echo "GNOME Desktop configured! You may need to log out and back in for all changes to take effect."
