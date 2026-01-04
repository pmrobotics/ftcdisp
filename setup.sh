#!/bin/bash

echo "1. Raspi-config settings..."
  config_rpi() {
    printf "  %-40s # %s\n" "sudo raspi-config $1 $2" "$3"
    # sudo raspi-config "$1" "$2"
  }

while read cfg arg1 rest
do
  config_rpi "$cfg" "$arg1" "$rest"
done <<"END_RASPI_CONFIG"
do_blanking 1 		Disable screen blanking 
do_boot_splash 1        Disable splash screen
do_ssh 0                Enable ssh
do_vnc 0                Enable vnc
END_RASPI_CONFIG

echo "2. Disable services..."
  config_svc() {
    printf "  %-40s # %s\n" "sudo systemctl $1 $2" "$3"
    # sudo systemctl "$1" "$2"
  }
while read cmd svc rest
do
  config_svc "$cmd" "$svc" "$rest"
done <<"END_RASPI_SERVICE"
stop cups-browsed	Stop cups service
disable cups-browsed	Disable cups service
disable bluetooth	Disable bluetooth
END_RASPI_SERVICE

PKGS="wlrctl xdotool"
echo "3. Install wlrctl/xdotool (enables mouse click for audio)..."
echo "  sudo apt satisfy $PKGS"
# sudo apt satisfy $PKGS

echo "4. Set up autostart file..."
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
