# TODO maybe install git sync and stop the obsidian sync subscription.
#!/bin/bash
set -e

echo "Installing Obsidian..."

cd /tmp

# 1. Fetch the latest version number from GitHub
OBSIDIAN_VERSION=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -Po '"tag_name": "v\K[^"]*')

# 2. Download the .deb package
wget -q -O obsidian.deb "https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian_${OBSIDIAN_VERSION}_amd64.deb"

# 3. Install it natively
sudo apt install -y ./obsidian.deb

# 4. Cleanup
rm obsidian.deb
cd -

echo "Obsidian installed successfully!"
