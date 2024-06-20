#! /bin/bash
source ./vars.sh

echo "Installing parted utility to make partitioning process easier"
pacman -S --noconfirm parted

echo "Creating partitions on $DISK"
if [ ! -b "$DISK" ]; then
	echo "Disk $DISK does not exist."
	exit
fi

parted $DISK --script mklabel gpt

ESP_OFFSET_MB=$(($ESP_SIZE_MB + $OFFSET_MB))
parted $DISK --script mkpart ESP fat32 "$OFFSET_MB"MiB "$ESP_OFFSET_MB"MiB

SWAP_OFFSET_MB=$(($SWAP_SIZE_MB + $ESP_OFFSET_MB))
parted $DISK --script mkpart primary linux-swap "$ESP_OFFSET_MB"MiB "$SWAP_OFFSET_MB"MiB

ROOT_OFFSET="100%"
parted $DISK --script mkpart primary ext4 "$SWAP_OFFSET_MB"MiB "$ROOT_OFFSET"

cryptsetup -y -v luksFormat "$DISK"p3
cryptsetup open "$DISK"p3 $ROOT_NAME
mkfs.ext4 /dev/mapper/$ROOT_NAME

mount /dev/mapper/$ROOT_NAME /mnt
mkfs.fat -F 32 "$DISK"p1

mount --mkdir "$DISK"p1 /mnt/boot
mkfs.ext4 -L $SWAP_NAME "$DISK"p2
