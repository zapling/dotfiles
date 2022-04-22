#!/bin/bash
# Setup script for easily configuring a new computer.

HOME=~
CURDIR=$(pwd)

INSTALL_PACKAGES="i3-gaps dmenu-manjaro i3blocks xwallpaper go alacritty zsh redshift xorg-xbacklight \
    xorg-xrandr \
    picom \
    neovim xclip npm yarn \
    ttf-liberation \
    ripgrep \
    docker \
    docker-compose \
    jq \
    postgresql
    "

SYMLINK_FILES=".Xresources .zshrc .zshenv .gtkrc-2.0 .gitconfig .gitignore-global"

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


    #nvim +PlugInstall +qall && echo "neovim setup done."
    echo "Skipping nvim post install."

    # Setup LSP servers

    if ! type "gopls" > /dev/null; then
        echo "Installing gopls"
        go install golang.org/x/tools/gopls@latest
    else
        echo "gopls already installed."
    fi

    if ! type "tsserver" > /dev/null; then
        echo "Installing typescript-language-server"
        sudo npm install -g typescript typescript-language-server  # TypeScript LSP
    else
        echo "typescript-language-server already installed."
    fi

    if ! type "lua-language-server" > /dev/null; then
        echo "Installing lua language server"
        sudo pacman -S lua-language-server
    else
        echo "lua-language-server already installed."
    fi

    if ! type "bash-language-server" > /dev/null; then
        echo "Installing bash language server"
        sudo npm install -g bash-language-server
    else
        echo "bash language server already installed."
    fi

    # Other linters

    # Linter for bash and shell script
    if ! type "shellcheck" > /dev/null; then
        echo "Installing shellcheck linter"
        pamac build --no-confirm shellcheck-bin
    else
        echo "shellcheck linter already installed."
    fi

    # eslint_d for typescript / javascript
    if ! type "eslint_d" > /dev/null; then
        echo "Installing eslint_d linter"
        sudo npm install -g eslint_d
    else
        echo "eslint_d linter already installed."
    fi

    # prettierd (formatter for ts js etc)
    if ! type "prettierd" > /dev/null; then
        echo "Installing prettierd formatter"
        sudo npm install -g @fsouza/prettierd
    else
        echo "prettierd formatter already installed."
    fi

    # LiberationMono Nerd font (LiterationMono Nerd Font)
    # https://www.nerdfonts.com/font-downloads
    if [[ ! -d "$HOME/.fonts" ]]; then
        echo "Installing LiberationMono Nerd Font (LiterationMono)"
        curl "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/LiberationMono.zip" -L --output "/tmp/LiberationMono.zip" && \
            mkdir "$HOME/.fonts" && \
            unzip /tmp/LiberationMono.zip -d "$HOME/.fonts" && \
            fc-cache -fv
    else
        echo "LiberationMono Nerd Font already installed"
    fi

    # deadd-notification-center
    if ! type "deadd-notification-center" > /dev/null; then
        echo "Installing deadd-notification-center-bin from AUR"
        pamac build --no-confirm deadd-notification-center-bin
    else
        echo "deadd-notification-center already installed."
    fi

    # notify-send.sh - Improved notify-send
    if ! type "notify-send.sh" > /dev/null; then
        echo "Installing notify-send.sh from AUR"
        pamac build --no-confirm notify-send.sh
    else
        echo "notify-send.sh already installed"
    fi

    echo "=== END POST INSTALL==="
}

function setup_grub() {
    find=$(grep -o "#GRUB_BACKGROUND=" /etc/default/grub)
    if [[ "$find" != "" ]]; then
        echo "Setup custom grub image..."
        sudo cp ~/dotfiles/wall/grub/gta-stallman.png /usr/share/grub/.
        sudo sed -i "s/#GRUB_BACKGROUND=.*/GRUB_BACKGROUND=\"\/usr\/share\/grub\/gta-stallman.png\"/" /etc/default/grub
        sudo sed -i "s/GRUB_THEME/#GRUB_THEME/" /etc/default/grub
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
        echo "Custom grub image already setup"
    fi
}

sudo pacman -Sy && install && setup_symlinks && post_install && setup_grub && echo "Setup completed!"

