#!/usr/bin/env bash
#This script creates symlinks to all the dotfiles

dot_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../dotfiles"

# Bash
ln -sf ${dot_dir}/bash_profile ~/.bash_profile

# Sway
ln -sf ${dot_dir}/sway ~/.config/sway/config

