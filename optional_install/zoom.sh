#!/bin/bash
set -e

wget -O zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb -y
rm zoom_amd64.deb
