#!/bin/bash
set -e

sudo snap install telegram-desktop

mkdir -p ~/.config/autostart

cat <<EOF >~/.config/autostart/telegram-desktop.desktop
[Desktop Entry]
Type=Application
Name=Telegram Desktop
Exec=telegram-desktop -startintray
Terminal=false
StartupNotify=false
EOF

echo "Telegram will now start minimized to the system tray on boot."
