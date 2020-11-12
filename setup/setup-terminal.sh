#!/bin/bash

echo -e "\033[1;34mTERMINAL SETUP\033[0m"

# Install packages related to the terminal
packages='kitty zsh'
sudo pacman -Sy --needed $packages

# Install oh-my-zsh if not installed
[ -d "~/.oh-my-zsh" ] && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make zsh default shell
[[ ! "$SHELL" =~ "zsh" ]] && chsh -s $(which zsh)

# Setup symlinks
cd ~ && \
    [ ! -L ".zshrc" ] && \
    rm .zshrc && \
    ln -s ~/dotfiles/.zshrc

cd ~ && \
    [ ! -L ".zshenv" ] && \
    rm .zshenv && \
    ln -s ~/dotfiles/.zshenv

cd ~/.oh-my-zsh/custom/themes/ && \
    [ ! -L "sunaku-zapling.zsh-theme" ] && \
    ln -s ~/dotfiles/.oh-my-zsh/custom/sunaku-zapling.zsh-theme

exit 0
