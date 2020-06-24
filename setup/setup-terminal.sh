#!/bin/bash

echo -e "\033[1;34mTERMINAL SETUP\033[0m"

# Install packages related to the terminal
packages='kitty zsh'
sudo pacman -Sy --needed $packages

# Install oh-my-zsh if not installed
[ -d "~/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make zsh default shell
chsh -s $(which zsh) || true

# Setup symlinks
cd ~
[ ! -L ".zshrc" ] && rm .zshrc && ln -s ~/dotfiles/.zshrc
cd .oh-my-zsh
[ ! -L "custom" ] && rm -rf custom && ln -s ~/dotfiles/.oh-my-zsh/custom

exit 0
