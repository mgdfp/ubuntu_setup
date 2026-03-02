#!/bin/bash
set -e

# Create font directory if it doesn't exist
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Temporary workspace
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Installing Cascadia Code Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip -q CascadiaMono.zip -d Cascadia
cp Cascadia/*.ttf "$FONT_DIR/"

echo "Installing iA Writer Mono..."
wget -q -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
unzip -q iafonts.zip
# Using 'find' is safer than hardcoding the path
find iA-Fonts-master -name "*.ttf" -exec cp {} "$FONT_DIR/" \;

# Clean up and refresh
cd ~
rm -rf "$TEMP_DIR"
fc-cache -f

echo "Fonts installed successfully!"
