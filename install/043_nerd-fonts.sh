#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

# 1. Define font directory
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# 2. Install Cascadia Code Nerd Font (CaskaydiaCove)
if is_any_file_installed "$FONT_DIR/*Caskaydia*"; then
  echo "  ✓ Cascadia Code Nerd Font is already installed."
else
  echo "  ➜ Installing Cascadia Code Nerd Font..."
  TEMP_DIR=$(mktemp -d)
  cd "$TEMP_DIR"

  wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
  unzip -q CascadiaMono.zip -d Cascadia
  cp Cascadia/*.ttf "$FONT_DIR/"

  cd "$HOME"
  rm -rf "$TEMP_DIR"
fi

# 3. Install iA Writer Mono
if is_any_file_installed "$FONT_DIR/*iAWriter*"; then
  echo "  ✓ iA Writer is already installed."
else
  echo "  ➜ Installing iA Writer Mono..."
  TEMP_DIR=$(mktemp -d)
  cd "$TEMP_DIR"

  wget -q -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip -q iafonts.zip
  find iA-Fonts-master -name "*.ttf" -exec cp {} "$FONT_DIR/" \;

  cd "$HOME"
  rm -rf "$TEMP_DIR"
fi

# 4. Refresh font cache (Only if something was actually installed)
# Note: It's fast enough to run every time, but we'll keep it here at the end.
fc-cache -f

echo "Font installation process complete!"
