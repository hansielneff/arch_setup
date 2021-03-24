#!/bin/sh
# This script creates symlinks to all the dotfiles

dot_dir="/home/$USER/arch_setup/dotfiles"

ln -sf ${dot_dir}/xorg-xinit/xinitrc ~/.xinitrc
ln -sf ${dot_dir}/xorg-xinit/xserverrc ~/.xserverrc
ln -sf ${dot_dir}/st/config.h ~/packages/st/config.h
ln -sf ${dot_dir}/st/PKGBUILD ~/packages/st/PKGBUILD
ln -sf ${dot_dir}/dwm/config.h ~/packages/dwm/config.h
ln -sf ${dot_dir}/dwm/PKGBUILD ~/packages/dwm/PKGBUILD

