#!/bin/bash
# Setup script for easily configuring a new computer.

HOME=~
CURDIR=$(pwd)

INSTALL_PACKAGES="i3-gaps dmenu-manjaro i3blocks xwallpaper dunst go kitty zsh \
    neovim xclip npm"

SYMLINK_FILES=".Xresources .zshrc .zshenv"

diff_file() {
    TARGET=$1
    FULLPATH=$HOME/$TARGET

    test -L "$FULLPATH" && return 0

    echo "=== $FULLPATH ==="

    if [ -e "$FULLPATH" ] ; then
        ls -lh "$FULLPATH"
        if cmp "$FULLPATH" "$CURDIR/$TARGET" ; then
            echo "same content"
        else
            diff -u "$FULLPATH" "$CURDIR/$TARGET"
        fi

        echo ""
        read -p "Replace regular file $FULLPATH with symlink? (y/n) " -n 1 choice
        echo ""

        case "$choice" in
            y|Y)
                rm -r "$FULLPATH"
                ;;
            n|N)
                echo "skipped."
                return 0
                ;;
            *)
                ;;
        esac
    fi

    ln -s $CURDIR/$TARGET $HOME/$TARGET && echo "linked."
}

setup_symlinks() {
    for path in $CURDIR/.config/*; do
        dirname="$(basename "${path}")"
        diff_file ".config/$dirname"
    done

    for file in $SYMLINK_FILES; do
        diff_file $file
    done
}

install() {
    echo "=== PACKAGE INSTALL ==="
    sudo pacman -Sy --needed $INSTALL_PACKAGES
}

post_install() {
    echo "=== START POST INSTALL ==="

    echo "=== SYSTEM ==="

    # i3lock-color was ditched from stabel community for some reason, get it from AUR instead.
    if ! type "i3lock" > /dev/null; then
        echo "Installing i3lock-color from AUR"
        pamac build --no-confirm i3lock-color
    fi

    # xkblayout-state-git needed for keyboard layout indicator, found in AUR
    if ! type "xkblayout-state" > /dev/null; then
        echo "Installing xkblayout-state-git from aur"
        pamac build --no-confirm xkblayout-state-git
    fi

    # Display settings, auto configure monitors
    if ! type "i3-autodisplay" > /dev/null; then
        echo "Installing i3-autodisplay"
        cd /tmp && git clone https://github.com/lpicanco/i3-autodisplay.git && \
            cd i3-autodisplay && \
            go build cmd/i3-autodisplay/i3-autodisplay.go && \
            sudo mv i3-autodisplay /usr/bin/.
    fi

    # Install oh-my-zsh
    [ ! -d "$HOME/.oh-my-zsh" ] && \
        echo "Installing oh-my-zsh" && \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
        ln -s "$CURDIR/.oh-my-zsh/custom/themes" "$HOME/.oh-my-zsh/custom/."

    # Set zsh as default shell
    [[ ! "$SHELL" =~ "zsh" ]] && chsh -s $(which zsh) && echo "ZSH set as default shell"

    echo "=== VIM ==="

    vim_dirs="$HOME/.vim $HOME/.vim/backup $HOME/.vim/backupf"
    for dir in $vim_dirs; do
        [ ! -d $dir ] && mkdir $dir && echo "created $dir"
    done

    nvim +PlugInstall +qall

    echo "=== END POST INSTALL==="
}

install && post_install && setup_symlinks && echo "Setup completed!"

