#!/bin/bash

# Install the ZapZap WhatsApp client
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.rtosta.zapzap
