#!/bin/sh
# This script creates symlinks to all the dotfiles

dot_dir="$HOME/arch_setup/dotfiles"

mkdir $HOME/.config
ln -sf ${dot_dir}/xorg-xinit/xinitrc		~/.xinitrc
ln -sf ${dot_dir}/xorg-xinit/xserverrc		~/.xserverrc
ln -sf ${dot_dir}/i3/config			~/.config/i3/config
mkdir $HOME/.config/i3status
ln -sf ${dot_dir}/i3status/config		~/.config/i3status/config
ln -sf ${dot_dir}/picom/picom.conf		~/.config/picom.conf
mkdir $HOME/.config/gtk-3.0
ln -sf ${dot_dir}/gtk3/settings.ini		~/.config/gtk-3.0/settings.ini
mkdir $HOME/.config/zsh
ln -sf ${dot_dir}/zsh/zshrc			~/.config/zsh/.zshrc
ln -sf ${dot_dir}/zsh/zprofile			~/.config/zsh/.zprofile
ln -sf ${dot_dir}/zsh/zshenv			~/.zshenv
ln -sf ${dot_dir}/alacritty/alacritty.yml	~/.config/alacritty.yml
ln -sf ${dot_dir}/starship/starship.toml	~/.config/starship.toml

