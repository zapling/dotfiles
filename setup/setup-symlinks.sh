#!/bin/zsh

dotfiles=$HOME/dotfiles

#==========
# Delete existing dotfiles / symlinks
#==========
#rm -rf ~/.zshrc
#rm -rf ~/.config/i3/
#rm -rf ~/.config/polybar/
#rm -rf ~/.config/kitty/

#==========
# Create symlinks
#==========
ln -s $dotfiles/.zshrc ~/.zshrc
ln -s $dotfiles/.config/i3 ~/.config/i3/
ln -s $dotfiles/.config/polybar ~/.config/polybar/
ln -s $dotfiles/.config/kitty ~/.config/kitty/

#==========
# Set zsh as the default shell
#==========
chsh -s /bin/zsh
