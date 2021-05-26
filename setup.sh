#!/bin/bash
# Setup script for easily configuring a new computer.

HOME=~
CURDIR=$(pwd)

INSTALL_PACKAGES="i3-gaps dmenu-manjaro i3blocks xwallpaper dunst go alacritty zsh redshift xorg-xbacklight \
    neovim xclip npm \
    ttf-liberation \
    ripgrep
    "

SYMLINK_FILES=".Xresources .zshrc .zshenv .gtkrc-2.0"

# todo: rename function to something better
diff_file() {
    TARGET=$1
    FULLPATH=$HOME/$TARGET

    test -L "$FULLPATH" && echo "$TARGET already linked." && return 0

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
    echo "=== SETUP SYMLINKS ==="
    # symlink all folders under .config/
    for path in $CURDIR/.config/*; do
        dirname="$(basename "${path}")"
        diff_file ".config/$dirname"
    done

    # symlink other specific files, .zshrc etc
    for file in $SYMLINK_FILES; do
        diff_file $file
    done

    # symlink scripts
    diff_file ".local/bin"
}

install() {
    echo "=== PACKAGE INSTALL ==="
    sudo pacman -Sy --needed $INSTALL_PACKAGES
}

post_install() {
    echo "=== START POST INSTALL ==="

    # install crontab
    if [[ $(crontab -l | diff - $HOME/dotfiles/cronjobs | wc -l) -ne 0 ]]; then
        echo "Installing crontab..."
        crontab $HOME/dotfiles/cronjobs
    else
        echo "Crontab is already installed."
    fi

    # set zsh as default shell
    if [[ ! "$SHELL" =~ "zsh" ]]; then
        chsh -s $(which zsh) && echo "ZSH set as default shell."
    else
        echo "ZSH is already the default shell."
    fi

    # gruvbox gtk theme and icons
    if [[ ! -d "/usr/share/themes/gruvbox-dark-gtk" ]]; then
        echo "Installing gruvbox-dark-gtk from AUR"
        pamac build --no-confirm gruvbox-dark-gtk
        pamac build --no-confirm gruvbox-dark-icons-gtk
    else
        echo "gruvbox-dark-gtk already installed."
    fi

    # i3lock-color was ditched from stabel community for some reason, get it from AUR instead.
    if ! type "i3lock" > /dev/null; then
        echo "Installing i3lock-color from AUR"
        pamac build --no-confirm i3lock-color
    else
        echo "i3lock-color already installed."
    fi

    # xkblayout-state-git needed for keyboard layout indicator, found in AUR
    if ! type "xkblayout-state" > /dev/null; then
        echo "Installing xkblayout-state-git from AUR"
        pamac build --no-confirm xkblayout-state-git
    else
        echo "xkblayout-state already installed."
    fi

    # Display settings, auto configure monitors
    if ! type "i3-autodisplay" > /dev/null; then
        echo "Installing i3-autodisplay"
        cd /tmp && git clone https://github.com/lpicanco/i3-autodisplay.git && \
            cd i3-autodisplay && \
            go build cmd/i3-autodisplay/i3-autodisplay.go && \
            sudo mv i3-autodisplay /usr/bin/.
    else
        echo "i3-autodisplay already installed."
    fi

    # Install oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh" && \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
        ln -s "$CURDIR/.oh-my-zsh/custom/themes/sunaku-zapling.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/."
    else
        echo "oh-my-zsh already installed."
    fi

    # Neovim
    vim_dirs="$HOME/.vim $HOME/.vim/backup $HOME/.vim/backupf"
    for dir in $vim_dirs; do
        [ ! -d $dir ] && mkdir $dir && echo "created neovim directory $dir"
    done

    nvim +PlugInstall +qall && echo "neovim setup done."

    # Go language server
    go install golang.org/x/tools/gopls@latest

    echo "=== END POST INSTALL==="
}

sudo pacman -Sy && install && setup_symlinks && post_install && echo "Setup completed!"

