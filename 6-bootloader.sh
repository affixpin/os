#! /bin/bash

source ./vars.sh

if [ -z "$ROOT_PARTITION_UUID" ]; then
  echo "Specify root partition uuid in vars.sh"
  exit
fi

# efibootmgr --create --disk /dev/nvme0n1 --part 1 --label artix --loader /vmlinuz-linux --unicode "cryptdevice=UUID=$ROOT_PARTITION_UUID:root root=/dev/mapper/root quite rw initrd=initramfs-linux.img"
# efibootmgr --create --disk /dev/nvme0n1 --part 1 --label artix --loader /vmlinuz-linux-lts --unicode "cryptdevice=UUID=$ROOT_PARTITION_UUID:root root=/dev/mapper/root quite rw initrd=initramfs-linux-lts.img"
efibootmgr --create --disk /dev/nvme0n1 --part 1 --label artix --loader /vmlinuz-linux-zen -u "cryptdevice=UUID=$ROOT_PARTITION_UUID:root root=/dev/mapper/root rw splash initrd=initramfs-linux-zen.img"
