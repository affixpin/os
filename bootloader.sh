#! /bin/bash

source ./vars.sh

efibootmgr --create --disk /dev/nvme0n1 --part 1 --label artix --loader /vmlinuz-linux --unicode 'cryptdevice=LABEL=root:root root=/dev/mapper/root quite rw initrd=initramfs-linux.img'
