#!/bin/bash
set -e

sudo add-apt-repository universe -y
sudo apt update -qq  
sudo apt install -y -qq flatpak gnome-software-plugin-flatpak  
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
