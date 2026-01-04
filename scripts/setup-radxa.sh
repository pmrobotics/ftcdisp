#!/bin/bash

echo "* Set autologin for $USER"
echo sudo bash -c "source /usr/lib/rsetup/cli/system.sh; set_gdm_autologin $USER ON"
sudo bash -c "source /usr/lib/rsetup/cli/system.sh; set_gdm_autologin $USER ON"

echo "* Install python3-jinja2"
echo sudo apt satisfy python3-jinja2
sudo apt satisfy python3-jinja2

echo "* Disable screen lock"
echo kwriteconfig5 --file kscreenlockerrc --group Daemon --key Autolock false
kwriteconfig5 --file kscreenlockerrc --group Daemon --key Autolock false

echo "* Set up autostart file..."
TMP="/var/tmp/ftcdisp.desktop"
AUTOSTART_DIR="$HOME/.config/autostart"
cat <<END_AUTOSTART >$TMP
[Desktop Entry]
Type=Application
Name=FTCdisp
Exec=sh -c "cd $PWD; /usr/bin/python3 ftcdisp.py >>server.log 2>&1 &"
Terminal=true
END_AUTOSTART
echo "  Contents of $TMP:"
sed 's/^/    /' $TMP
echo "  mkdir -p $AUTOSTART_DIR"
mkdir -p $AUTOSTART_DIR
echo "  cp -i $TMP $AUTOSTART_DIR"
cp -i $TMP $AUTOSTART_DIR
