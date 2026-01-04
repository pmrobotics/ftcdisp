#!/bin/bash

echo "* Set autologin for $USER"
echo sudo bash -c "source /usr/lib/rsetup/cli/system.sh; set_gdm_autologin $USER ON"
sudo bash -c "source /usr/lib/rsetup/cli/system.sh; set_gdm_autologin $USER ON"

echo "* Enable ssh"
echo sudo systemctl enable ssh
sudo systemctl enable --now ssh

echo "* Disable screen lock"
echo kwriteconfig5 --file kscreenlockerrc --group Daemon --key Autolock false
kwriteconfig5 --file kscreenlockerrc --group Daemon --key Autolock false
