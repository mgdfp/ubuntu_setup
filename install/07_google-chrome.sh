#!/bin/bash
set -e
echo "Installing google chrome"

# Browse the web with the most popular browser. See https://www.google.com/chrome/
cd /tmp
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y -qq ./google-chrome-stable_current_amd64.deb >/dev/null
rm google-chrome-stable_current_amd64.deb
xdg-settings set default-web-browser google-chrome.desktop
cd -
