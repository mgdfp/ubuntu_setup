#!/bin/bash
set -e

# Check if it is already installed
if is_apt_installed "appimagelauncher"; then
  echo "AppImageLauncher is already installed. Skipping..."
else
  echo "Installing AppImageLauncher..."

  # 1. Install dependencies for Ubuntu 24.04 (Noble)
  sudo apt update -qq >/dev/null
  sudo apt install -y -qq libsqlite3-0 libfuse2t64 curl

  # 2. Scrape the latest release (including pre-releases/betas)
  cd /tmp
  URL=$(curl -s https://api.github.com/repos/TheAssassin/AppImageLauncher/releases |
    grep "browser_download_url" |
    grep "amd64.deb" |
    grep -v "bionic" | grep -v "xenial" | grep -v "trusty" |
    head -n 1 |
    cut -d '"' -f 4)

  echo "Downloading latest AppImageLauncher: $URL"
  wget -q -O appimagelauncher.deb "$URL"

  # 3. Install via apt (to handle any other sub-dependencies)
  sudo apt install -y -qq ./appimagelauncher.deb

  # 4. Cleanup
  rm appimagelauncher.deb
  cd - >/dev/null

  echo "AppImageLauncher installation complete!"
fi
