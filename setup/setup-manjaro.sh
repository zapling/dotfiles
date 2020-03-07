#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run setup as root"
  exit 1
fi

install_packages() {
    local packages=''

    # drivers
    packages+=' mesa'

    # i3 wm
    packages+=' i3-gaps i3status-manjaro i3-lock dmenu-manjaro polybar feh'

    # Terminal
    packages+=' zsh kitty'

    # Fonts
    package+=' noto-fonts-emoji'

    # Misc programs
    packages+=' neofetch'

    pacman -Sy --noconfirm $packages
}

setup_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_driver_configs() {
    # Intel driver configuration
    ln -s $PWD/etc-x11-xorg-conf-d/20-intel.conf /etc/X11/xorg.conf.d/

    # Touchpad configuration
    ln -s $PWD/etc-x11-xorg-conf-d/30-touchpad.conf /etc/X11/xorg.conf.d/ 
}

setup_driver_configs
install_packages
setup_oh_my_zsh
