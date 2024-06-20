#! /bin/bash
DISK="/dev/nvme0n1"

OFFSET_MB=1
ESP_SIZE_MB=1024
SWAP_SIZE_MB=$((1024 * 16))
ROOT_NAME="rootencrypted"
SWAP_NAME="swapencrypted"

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

