#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq >/dev/null 2>&1

echo "Installing Zellij..."
sudo snap install zellij --classic

echo "Zellij setup complete!"
