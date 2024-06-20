#! /bin/bash

export WIFI_SSID=MEO-05C0B0
export WIFI_PASSWORD=a8b1cb2346|ZZ

# rfkill unblock wlan
# ip link set wlan0 down
# ip link set wlan0 up

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
sudo ln -s /etc/runit/sv/wpa_supplicant /etc/runit/runsvdir/default/
sv start wpa_supplicant
sudo ln -s /etc/runit/sv/dhcpcd /etc/runit/runsvdir/default/
sv start dhcpcd
