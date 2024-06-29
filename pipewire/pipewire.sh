#! /bin/bash

sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber

sudo chmod +x sv/pipewire-pulse/run
sudo chmod +x sv/pipewire/run
sudo chmod +x sv/wireplumber/run

if [ ! -e /etc/runit/runsvdir/default/wireplumber ]; then
  sudo ln -s "$(pwd)"/sv/wireplumber /etc/runit/runsvdir/default/
fi

if [ ! -e /etc/runit/runsvdir/default/pipewire ]; then
  sudo ln -s "$(pwd)"/sv/pipewire /etc/runit/runsvdir/default/
fi

if [ ! -e /etc/runit/runsvdir/default/pipewire-pulse ]; then
  sudo ln -s "$(pwd)"/sv/pipewire-pulse /etc/runit/runsvdir/default/
fi

sudo sv start pipewire
sudo sv start pipewire-pulse
sudo sv start wireplumber
