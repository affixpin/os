#! /bin/bash

if [ ! -e /etc/runit/runsvdir/default/ntpd ]; then
  sudo ln -s /etc/runit/sv/ntpd /etc/runit/runsvdir/default/
fi

sv start ntpd

basestrap /mnt base base-devel runit elogind-runit
basestrap /mnt linux-lts linux-firmware intel-ucode
basestrap /mnt dhcpcd dhcpcd-runit wpa_supplicant wpa_supplicant-runit neovim efibootmgr git mkinitcpio cryptsetup cryptsetup-runit neofetch man-db mesa sudo sway alacritty sudo xorg-server-xwayland bluez bluez-runit blueman mako tmux vim

fstabgen -U /mnt >> /mnt/etc/fstab
