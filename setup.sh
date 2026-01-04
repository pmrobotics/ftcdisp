#!/bin/bash

if grep -q "Raspberry Pi" /proc/device-tree/model
then 
  echo "* Setting up for Raspberry Pi environment"
  scripts/setup-raspi.sh
fi

PKGS="python3-wakepy python3-jinja2 wlrctl xdotool"
echo "* Install wlrctl/xdotool (enables mouse click for audio)..."
echo "  sudo apt satisfy $PKGS"
sudo apt satisfy $PKGS

echo "* Set up autostart file..."
TMP="/var/tmp/ftcdisp.desktop"
AUTOSTART_DIR="$HOME/.config/autostart"
cat <<END_AUTOSTART >$TMP
[Desktop Entry]
Type=Application
Name=FTCdisp
Exec=sh -c "cd $PWD; systemd-inhibit --what=idle /usr/bin/python3 ftcdisp.py >>server.log 2>&1 &"
Terminal=true
END_AUTOSTART
echo "  Contents of $TMP:"
sed 's/^/    /' $TMP
echo "  mkdir -p $AUTOSTART_DIR"
mkdir -p $AUTOSTART_DIR
echo "  cp -i $TMP $AUTOSTART_DIR"
cp -i $TMP $AUTOSTART_DIR
