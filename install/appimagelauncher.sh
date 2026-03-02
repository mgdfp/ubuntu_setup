#!/bin/bash
set -e

# 1. Install dependencies
sudo apt update
sudo apt install -y libsqlite3-0 libfuse2t64

# 2. Scrape the latest release URL for the amd64 .deb package
cd /tmp
URL=$(curl -s https://api.github.com/repos/TheAssassin/AppImageLauncher/releases/latest |
  grep "browser_download_url" |
  grep "amd64.deb" |
  grep -v "bionic" |
  head -n 1 |
  cut -d '"' -f 4)

echo "Downloading AppImageLauncher from $URL..."
wget -q -O appimagelauncher.deb "$URL"

# 3. Install the package
sudo apt install -y ./appimagelauncher.deb

# 4. Cleanup
rm appimagelauncher.deb
cd -

echo "AppImageLauncher installation complete!"
