#!/usr/bin/bash

if ! type "git" > /dev/null; then
    pacman -Sy --needed git
fi

if [[ ! -d ~/dotfiles ]]; then
    git clone git@github.com:zapling/dotfiles.git ~/dotfiles
fi

echo "You are about to run a bunch of scripts, are you sure?"
read -p "Press any key to continue" -n 1

for setup_step in ~/dotfiles/setup/steps/*; do
    echo -e "\nExecuting ${setup_step}\n"
    source "$setup_step"
done

echo -e "\nAlmost there, restart your terminal and you should be done!"
