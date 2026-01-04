#!/bin/bash

echo "* [raspi] Raspi-config settings..."
  config_rpi() {
    printf "  %-40s # %s\n" "sudo raspi-config nonint $1 $2" "$3"
    sudo raspi-config nonint "$1" "$2"
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

echo "* [raspi] Disable services..."
  config_svc() {
    printf "  %-40s # %s\n" "sudo systemctl $1 $2" "$3"
    sudo systemctl "$1" "$2"
  }
while read cmd svc rest
do
  config_svc "$cmd" "$svc" "$rest"
done <<"END_RASPI_SERVICE"
stop cups-browsed	Stop cups service
disable cups-browsed	Disable cups service
disable bluetooth	Disable bluetooth
END_RASPI_SERVICE

