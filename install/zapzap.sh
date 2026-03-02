##!/bin/bash

# Install the ZapZap WhatsApp client
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#flatpak install -y flathub com.rtosta.zapzap

#!/bin/bash
set -e

# 1. Create the icons directory
mkdir -p ~/.local/share/icons

# 2. Download a high-quality WhatsApp icon
wget -q -O ~/.local/share/icons/whatsapp.png https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/512px-WhatsApp.svg.png

# 3. Create the Desktop Entry
cat <<EOF >~/.local/share/applications/whatsapp.desktop
[Desktop Entry]
Version=1.0
Name=WhatsApp
Comment=WhatsApp Web
Exec=google-chrome --app="https://web.whatsapp.com" --name=whatsapp --class=whatsapp
Terminal=false
Type=Application
Icon=$HOME/.local/share/icons/whatsapp.png
Categories=Network;Chat;
StartupNotify=true
StartupWMClass=whatsapp
EOF

echo "WhatsApp Web App created! You can now find it in your applications menu."
