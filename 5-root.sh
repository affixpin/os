#! /bin/bash
# change root before the script: artix-chroot /mnt

set -e

ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
touch /etc/hostname
echo "x" >> /etc/hostname
passwd
sed -i '/^HOOKS=(/ s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf
mkinitcpio -P linux
