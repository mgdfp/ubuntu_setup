#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq > /dev/null

echo "Installing Alacritty..."
sudo apt install -y -qq alacritty > /dev/null

echo "Setting Alacritty as the default terminal..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
