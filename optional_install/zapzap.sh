#!/bin/bash

# Install ZapZap via Flatpak
sudo flatpak install flathub com.rtosta.zapzap -y

# Create the autostart directory if it doesn't exist
mkdir -p ~/.config/autostart

# Generate the autostart file for ZapZap
cat <<EOF >~/.config/autostart/com.rtosta.zapzap.desktop
[Desktop Entry]
Name=ZapZap
Exec=flatpak run com.rtosta.zapzap --hideStart
Type=Application
X-GNOME-Autostart-enabled=true
EOF
