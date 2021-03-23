#!/bin/sh
# This script sets up a minimal Arch Linux installation with GRUB.
# Some parts will probably need to be modified in order to fit your needs.
# 
# Pre-requisites:
# 	- UEFI boot mode
# 	- A working internet connection

printf "Congratulations on making the right choice. (I use Arch btw)\n"

hostname="hostname"
install_disk="/dev/sda"
dualboot=0
timezone="Europe/Copenhagen"
keymap="dk"

# Update the system clock
timedatectl set-ntp true
timedatectl set-timezone "$timezone"

# Partition, format and mount
printf "Partition, format and mount the disk ($install_disk) however you want.
Mount the EFI partition at /mnt/boot/efi.
When you're done, press CTRL-D or type 'exit' to proceed."
/bin/sh

# Install essential packages
pacstrap /mnt base linux linux-firmware man-db man-pages networkmanager neovim git

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt sh -c "
	# Permanently set the system time
	ln -sf /usr/share/zoneinfo/'${timezone}' /etc/localtime
	hwclock --systohc

	# Uncomment en_US.UTF-8 localization, generate and configure env variables
	sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
	locale-gen
	printf 'LANG=en_US.UTF-8' > /etc/locale.conf
	printf 'KEYMAP=${keymap}' > /etc/vconsole.conf

	# Network configuration
	printf '${hostname}' > /etc/hostname
	printf '\n127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\t${hostname}.localdomain\t${hostname}\n' >> /etc/hosts
	systemctl enable NetworkManager

	# Set root password
	printf 'Set root password\n'
	passwd

	# Install and configure GRUB (Including Intel microcode which GRUB auto-configures)
	pacman -S grub efibootmgr intel-ucode
	
	$dualboot && {
		pacman -S os-prober
		printf 'Mount the main partition of the other OS, so GRUB can detect it.'
	}

	grub-install --target=x86_64-efi --efi-directory=boot/efi --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg
"

umount -R /mnt
printf "Finished installation. Remove installation media and reboot.\n"
