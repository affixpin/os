#! /bin/bash

source ./vars.sh

rfkill unblock wlan
ip link set wlan0 up

CONFIG=/etc/wpa_supplicant/wpa_supplicant.conf

if [ ! -e $CONFIG ]; then
  touch $CONFIG
  echo "ctrl_interface=/run/wpa_supplicant" >> $CONFIG
  echo "update_config=1" >> $CONFIG
fi

SV=/etc/runit/sv/wpa_supplicant
if [ ! -e $SV ]; then
	pacman -S wpa_supplicant-runit
fi

if [ ! -e /etc/runit/runsvdir/default/wpa_supplicant ]; then
  sudo ln -s /etc/runit/sv/wpa_supplicant /etc/runit/runsvdir/default/
fi

sv start wpa_supplicant
 
if [ -z "$WIFI_SSID" ]; then
  wpa_cli scan
  echo "Scanning..."
  sleep 3
  wpa_cli scan_results
  echo "Specify you network WIFI_SSID in vars.sh"
  exit
fi

if [ -z "$WIFI_PASSWORD" ]; then
  echo "Specify $WIFI_SSID password (WIFI_PASSWORD) in vars.sh"
  exit
fi

echo "ctrl_interface=/run/wpa_supplicant" > $CONFIG
echo "update_config=1" >> $CONFIG
wpa_passphrase $WIFI_SSID $WIFI_PASSWORD >> /etc/wpa_supplicant/wpa_supplicant.conf

if [ ! -e /etc/runit/runsvdir/default/dhcpcd ]; then
  sudo ln -s /etc/runit/sv/dhcpcd /etc/runit/runsvdir/default/
fi

sv start dhcpcd
