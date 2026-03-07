#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq

#removing nvim setup folders in case there is some corrupt files or locks.
rm -rf ~/.local/share/nvim/ ~/.local/state/nvim/ ~/.cache/nvim/

echo "Installing Neovim, Python, and Shell dependencies..."

# 1. Install System Dependencies
sudo apt install -y -qq libfuse2t64 make gcc python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli git ripgrep fd-find build-essential npm unzip

# Ubuntu installs fd-find as 'fdfind', but Neovim plugins hardcode the command 'fd'.
# This system-wide symlink ensures plugins like Telescope can actually find it.
sudo ln -sf $(which fdfind) /usr/local/bin/fd

# 2. Install Neovim (AppImage)
cd /tmp
curl -sSLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# 3. Setup Dedicated Python Provider Environment
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install pynvim

echo "Creating Neovim desktop entry..."
# Ensure local directories exist
mkdir -p ~/.local/share/icons/hicolor/128x128/apps/ ~/.local/share/applications

cp "$SCRIPT_DIR/../icons/nvim.png" ~/.local/share/icons/hicolor/128x128/apps/nvim.png

# Create a clean desktop entry that uses your Alacritty terminal
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
echo "Neovim Setup Complete! Run 'nvim' to bootstrap the plugins."

# 4. Refresh the caches so the dock sees it immediately
gtk-update-icon-cache ~/.local/share/icons/hicolor -f -t || true
update-desktop-database ~/.local/share/applications || true
