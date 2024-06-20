source ./vars.sh

efibootmgr --create --disk /dev/nvme0n1 --part 1 --label artix --loader /vmlinuz-linux --unicode 'cryptdevice=UUID=bb67bec8-d059-4b65-9b02-c2df5cf6141c:root root=/dev/mapper/$ROOT_NAME quite rw initrd=initramfs-linux.img'
