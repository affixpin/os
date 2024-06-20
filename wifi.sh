#! /bin/bash

export WIFI_SSID=
export WIFI_PASSWORD=

rfkill unblock wlan
ip link set wlan0 up

if [ -z "$WIFI_SSID" ]; then
  iw wlan0 scan | grep  SSID:
  echo "Specify you network SSID in wifi.sh"
  exit
fi

if [ -z "$WIFI_PASSWORD" ]; then
  echo "Specify $WIFI_SSID password in wifi.sh"
  exit
fi

wpa_passphrase $WIFI_SSID $WIFI_PASSWORD > /etc/wpa_supplicant/wpa_supplicant.conf

if [ ! -e /etc/runit/runsvdir/default/wpa_supplicant ]; then
  sudo ln -s /etc/runit/sv/wpa_supplicant /etc/runit/runsvdir/default/
fi

sv start wpa_supplicant

if [ ! -e /etc/runit/runsvdir/default/dhcpcd ]; then
  sudo ln -s /etc/runit/sv/dhcpcd /etc/runit/runsvdir/default/
fi

sv start dhcpcd
