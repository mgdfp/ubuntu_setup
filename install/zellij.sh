#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update

echo "Installing Zellij..."
sudo snap install zellij --classic

echo "configuring zellij"
mkdir -p ~/.config/zellij
cp "$SCRIPT_DIR/../configs/zellij.kdl" ~/.config/zellij/config.kdl
echo "Zellij setup complete!"
