#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

# 1. Install Flatpak and GNOME integration if not present
if is_command_installed "flatpak"; then
  echo "  ✓ Flatpak infrastructure is already set up."
else
  echo "  ➜ Setting up Flatpak and Flathub..."
  sudo add-apt-repository universe -y
  sudo apt update -qq
  sudo apt install -y -qq flatpak gnome-software-plugin-flatpak
fi

# 2. Add Flathub repository (safe to run even if it exists)
# The --if-not-exists flag handles the check for us natively
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Flatpak setup complete!"
