#!/bin/bash

echo -e "\033[1;34mVIM SETUP\033[0m"

packages='neovim xclip'

sudo pacman -Sy --needed $packages

cd ~
[ ! -d ".vim" ] && mkdir .vim && mkdir .vim/backup && mkdir && .vim/backupf
cd .config/
[ ! -L "nvim" ] && rm -rf nvim && ln -s ~/dotfiles/.config/nvim
nvim +PlugInstall +qall
