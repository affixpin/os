#! /bin/bash


if [ ! -e /etc/runit/runsvdir/default/bluetoothd ]; then
  sudo ln -s /etc/runit/sv/bluetoothd /etc/runit/runsvdir/default/
fi
