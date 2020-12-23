#!/bin/bash

echo -e "\033[1;34mI3 SETUP\033[0m"

# Install packages related to i3
packages='i3-gaps i3lock-color dmenu-manjaro i3blocks xwallpaper dunst go'

# i3blocks script dependencies
packages+=' acpi sysstat'

sudo pacman -Sy --needed $packages

# xkblayout-state-git needed for keyboard layout indicator
# found in aur
if ! type "xkblayout-state" > /dev/null; then
  pamac build --no-confirm xkblayout-state-git
fi

# Display settings, auto configure monitors
if ! type "i3-autodisplay" > /dev/null; then
    cd /tmp && git clone https://github.com/lpicanco/i3-autodisplay.git && \
        cd i3-autodisplay && \
        go build cmd/i3-autodisplay/i3-autodisplay.go && \
        sudo mv i3-autodisplay /usr/bin/.
fi

# Setup symlinks to configs
cd ~/.config/
[ ! -L "i3" ] && ln -s ~/dotfiles/.config/i3
[ ! -L "i3blocks" ] && ln -s ~/dotfiles/.config/i3blocks
[ ! -L "i3-autodisplay" ] && ln -s ~/dotfiles/.config/i3-autodisplay
[ ! -L "dunst" ] && ln -s ~/dotfiles/.config/dunst
[ ! -L "fontconfig"] && ln -s ~/dotfiles/.config/fontconfig

exit 0
