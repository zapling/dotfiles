#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run setup as root"
  exit 1
fi

install_packages() {
    local packages=''

    # i3 wm
    packages+=' i3-gaps i3status-manjaro dmenu-manjaro polybar'

    # Misc programs
    packages+=' neofetch'

    pacman -Sy --noconfirm $packages
}

setup_symlinks() {
    # Touchpad configuration
    ln -s $PWD/etc-x11-xorg-conf-d/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf 
}

setup_symlinks
