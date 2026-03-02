# Installs Flatpak (if missing) and the ZapZap WhatsApp client
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.rtosta.zapzap
