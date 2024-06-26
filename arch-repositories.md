/etc/pacman.conf

```
# Arch
[extra]
Include = /etc/pacman.d/mirrorlist-arch

[multilib]
Include = /etc/pacman.d/mirrorlist-arch
```

sudo pacman -S artix-archlinux-support

then uncomment mirrors at /etc/pacman.d/...
