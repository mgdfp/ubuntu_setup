#!/bin/bash
set -e

echo "Configuring custom keyboard shortcuts (Xfce)..."

# Flameshot region screenshot: Super+Shift+S
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super><Shift>s" -n -t string -s "flameshot gui"

# Open file manager: Super+E
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>e" -n -t string -s "thunar"

# Lock screen: Super+L
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>l" -n -t string -s "xflock4"

echo "Keyboard shortcuts configured!"
