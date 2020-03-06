#!/bin/zsh

dotfiles=$HOME/dotfiles

#==========
# Delete existing dotfiles / symlinks
#==========
rm -rf ~/.local/bin/
rm -rf ~/.zshrc
rm -rf ~/.config/i3/
rm -rf ~/.config/polybar/
rm -rf ~/.config/kitty/
rm -rf ~/.oh-my-zsh/custom/themes/

#==========
# Create symlinks
#==========
ln -s $dotfiles/bin/ ~/.local/
ln -s $dotfiles/.zshrc ~/.zshrc
ln -s $dotfiles/.config/i3 ~/.config/
ln -s $dotfiles/.config/polybar ~/.config/
ln -s $dotfiles/.config/kitty ~/.config/
ln -s $dotfiles/.oh-my-zsh/custom/themes/ ~/.oh-my-zsh/custom/

#==========
# Set zsh as the default shell
#==========
chsh -s /bin/zsh
