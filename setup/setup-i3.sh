#!/bin/bash

echo -e "\033[1;34mI3 SETUP\033[0m"

# Install packages related to i3
packages='i3-gaps i3lock-color dmenu-manjaro i3blocks xwallpaper dunst'

# i3blocks script dependencies
packages+=' acpi sysstat'

sudo pacman -Sy --needed $packages

# xkblayout-state-git needed for keyboard layout indicator
# found in aur
if ! type "xkblayout-state" > /dev/null; then
  pamac build --no-confirm xkblayout-state-git
fi

# Setup symlinks to configs
cd ~/.config/
[ ! -L "i3" ] && ln -s ~/dotfiles/.config/i3
[ ! -L "i3blocks" ] && ln -s ~/dotfiles/.config/i3blocks
[ ! -L "dunst" ] && ln -s ~/dotfiles/.config/dunst

exit 0
