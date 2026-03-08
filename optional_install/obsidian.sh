#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

# 1. Check if Flatpak is installed (using your shared function)
if ! is_command_installed "flatpak"; then
    echo "  ! Flatpak not found. Running flatpak setup first..."
    # Assuming your flatpak script is in the same folder
    source "$SCRIPT_DIR/../install/06_flatpak.sh"
fi

# 2. Install Obsidian via Flatpak
if is_flatpak_installed "md.obsidian.Obsidian"; then
    echo "  ✓ Obsidian is already installed."
else
    echo "  ➜ Installing Obsidian (Flatpak)..."
    flatpak install -y flathub md.obsidian.Obsidian
fi

echo "Obsidian setup complete!"
