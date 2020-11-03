#!/usr/bin/env bash
#This script creates symlinks to all the dotfiles

dot_dir = "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../dotfiles"

# xinit
ln -s ${dot_dir}/xinitrc ~/.xinitrc
ln -s ${dot_dir}/xserverrc ~/.xserverrc

# Bash
ln -s ${dot_dir}/bash_profile ~/.bash_profile
