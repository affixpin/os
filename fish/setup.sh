# /bin/bash

sudo pacman -S fish
echo /usr/bin | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
