#! /bin/bash
source ./vars.sh

echo "swap LABEL=$SWAP_NAME swap,cipher=aes-cbc-essiv:sha256,size=256" > /mnt/etc/crypttab
echo "/dev/mapper/$SWAP_NAME none swap defaults 0 0" >> /mnt/etc/fstab
