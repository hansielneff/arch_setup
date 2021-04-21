#!/bin/sh
# This script configures a newly installed system to my preferences
# This includes installing all the packages that I use

# Set zsh to be the user's default shell
chsh -s /bin/zsh

# Link /bin/sh to Dash instead of slow, fat Bash
sudo ln -sf /bin/dash /bin/sh

# Enable the multilib repo for 32-bit packages
sudo sed -i '/\[multilib\]/{s/#//;n;s/#//;}' /etc/pacman.conf
sudo pacman -Sy

# Install Paru to make installing AUR packages a breeze
git clone https://aur.archlinux.org/paru
cd paru
makepkg -si
cd ..
rm -rf paru

# Install the packages in package_list.txt
paru -S $(cut -f1 -d' ' $HOME/arch_setup/package_list.txt)

