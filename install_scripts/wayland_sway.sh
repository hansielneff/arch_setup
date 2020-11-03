#!/usr/bin/env bash
# This script sets up Wayland and Sway with open-source Nvidia drivers.
# Some parts will probably need to be modified in order to fit your needs.
#
# Pre-requisites:
# 	- A minimal Arch installation (See install_scripts/minimal.sh)
# 	- A working internet connection

# NOTE: This script is not yet finished and development is currently on pause.

sudo pacman -S sway dmenu alacritty

# Copy the sample configuration
mkdir -p .config/sway
cp /etc/sway/config .config/sway


