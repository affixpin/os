#! /bin/bash

if [ ! -e /mnt/root/affixpin-os ]; then
  cp -r $(pwd) /mnt/root/affixpin-os
fi

artix-chroot /mnt

