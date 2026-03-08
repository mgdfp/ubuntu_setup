#!/usr/bin/env bash
set -euo pipefail

# Directory where this script lives (used for the icon path)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq

# System dependencies (tree-sitter-cli from apt)
sudo apt install -y -qq \
  wget tar git ripgrep fd-find build-essential unzip \
  python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli

# Ubuntu installs fd-find as 'fdfind', but many plugins expect 'fd'
sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd

# Optional: wipe Neovim runtime dirs (keeps ~/.config/nvim intact)
rm -rf ~/.local/share/nvim/ ~/.local/state/nvim/ ~/.cache/nvim/

echo "Installing Neovim (Omakub/DHH method: stable tarball to /usr/local)..."

cd /tmp
rm -rf nvim-linux-x86_64 nvim.tar.gz

wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar -xf nvim.tar.gz
sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
sudo cp -R nvim-linux-x86_64/lib /usr/local/
sudo cp -R nvim-linux-x86_64/share /usr/local/
rm -rf nvim-linux-x86_64 nvim.tar.gz
cd - >/dev/null

# Python provider venv (optional but nice to keep)
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install -U pip pynvim

echo "Creating Neovim desktop entry..."
mkdir -p ~/.local/share/icons/hicolor/128x128/apps/ ~/.local/share/applications

cp "$SCRIPT_DIR/../icons/nvim.png" ~/.local/share/icons/hicolor/128x128/apps/nvim.png

cat <<EOF >~/.local/share/applications/nvim.desktop
[Desktop Entry]
Type=Application
Name=Neovim
GenericName=Text Editor
Comment=Edit text files
Icon=nvim
Exec=alacritty -e nvim %F
Terminal=false
Categories=Utilities;TextEditor;Development;
Keywords=Text;Editor;
StartupNotify=false
EOF

# Refresh caches (only if tools exist)
command -v gtk-update-icon-cache >/dev/null 2>&1 && gtk-update-icon-cache ~/.local/share/icons/hicolor -f -t || true
command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database ~/.local/share/applications || true

echo "Done."
