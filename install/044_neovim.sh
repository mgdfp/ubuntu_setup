#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq > /dev/null

echo "Installing Neovim, Python, and Shell dependencies..."

# 1. Install System Dependencies
sudo apt install -y -qq libfuse2t64 make gcc python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli git ripgrep fd-find build-essential npm unzip > /dev/null

# Ubuntu installs fd-find as 'fdfind', but Neovim plugins hardcode the command 'fd'.
# This system-wide symlink ensures plugins like Telescope can actually find it.
sudo ln -sf $(which fdfind) /usr/local/bin/fd

# 2. Install Neovim (AppImage)
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# 3. Setup Dedicated Python Provider Environment
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install pynvim

echo "Creating Neovim desktop entry..."
mkdir -p ~/.local/share/icons ~/.local/share/applications

# Download official Neovim icon
wget -qO ~/.local/share/icons/nvim.png "https://raw.githubusercontent.com/neovim/neovim/master/runtime/neovim.png"

# Create the desktop shortcut
cat <<'EOF' >~/.local/share/applications/nvim.desktop
[Desktop Entry]
Name=Neovim
GenericName=Text Editor
Exec=alacritty -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=TextEditor;Development;
EOF

echo "Neovim Setup Complete! Run 'nvim' to bootstrap the plugins."
