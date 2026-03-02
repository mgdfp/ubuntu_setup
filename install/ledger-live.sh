# Downloads the AppImage and sets the required USB permissions
wget https://download.live.ledger.com/latest/linux -O ~/ledger-live.AppImage
chmod +x ~/ledger-live.AppImage
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
