#!/bin/sh
# This script creates symlinks to all the dotfiles

dot_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../dotfiles"

ln -sf "${dot_dir}"/xinitrc ~/.xinitrc
ln -sf "${dot_dir}"/xserverrc ~/.xserverrc
