#! /bin/bash
source ./vars.sh

# offset param is important here, if not specified - filesystem label drops on boot
echo "swap LABEL=$SWAP_NAME /dev/urandom swap,offset=2048,cipher=aes-xts-plain64,size=512" > /mnt/etc/crypttab
echo "/dev/mapper/$SWAP_NAME none swap defaults 0 0" >> /mnt/etc/fstab
