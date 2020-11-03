#!/usr/bin/env bash
# This script sets up a minimal Arch Linux installation with GRUB.
# Some parts will probably need to be modified in order to fit your needs.
# 
# Pre-requisites:
# 	- UEFI boot mode
# 	- A working internet connection.

printf "Congratulations on making the right choice. (I use Arch btw)\n"

printf "Enter desired hostname: "
read hostname

printf "$(lsblk)\n\nEnter name of the device you wish to install Arch onto: "
read device

# Update the system clock
timedatectl set-ntp true
timedatectl set-timezone Europe/Copenhagen

# Partition, format and mount
parted -s /dev/${device} mklabel gpt mkpart EFI fat32 1MiB 261MiB set 1 esp on mkpart Home ext4 261MiB 100%

mkfs.fat -F32 /dev/${device}1
mkfs.ext4 /dev/${device}2

mkdir /mnt/efi
mount /dev/${device}1 /mnt/efi
mount /dev/${device}2 /mnt

# Install essential packages
pacstrap /mnt base base-devel linux linux-firmware vim networkmanager git

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt sh -c "
	# Permanently set the system time
	ln -sf /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime
	hwclock --systohc

	# Uncomment en_US.UTF-8 localization and generate
	sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
	locale-gen
	printf 'LANG=en_US.UTF-8' > /etc/locale.conf
	printf 'KEYMAP=dk' > /etc/vconsole.conf

	# Network configuration
	printf '${hostname}' > /etc/hostname
	printf '\n127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\t${hostname}.localdomain\t${hostname}\n' >> /etc/hosts
	systemctl enable --now NetworkManager

	# Set root password
	printf 'Root password\n'
	passwd

	# Install Intel microcode
	pacman -S intel-ucode

	# Install and configure GRUB
	pacman -S grub efibootmgr
	grub-install --target=x86_64-efi --efi-directory=efi --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg
"

printf "Finished installation. Remove installation media and reboot.\n"
