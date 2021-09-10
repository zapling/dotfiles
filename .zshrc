export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sunaku-zapling"

plugins=(git)

source $ZSH/oh-my-zsh.sh

protectDropdownTerminal () {
	ID=$(ps -p $$ -o ppid= | tr -d '[:space:]')
	PARAM=$(ps -p $ID o args=)
	if [[ $PARAM =~ "dropdown" ]];
	then
		alias exit="echo Na man!"
	fi
}

protectDropdownTerminal # Disable "exit" command if this is a dropdown terminal

# Source private stuff
[ -e ~/.private ] && source ~/.private

# Dialog if user meant to open vim or really vi
function vi() {
    echo -e "vi, did you mean vim? (y/n)"
    read -sk x
    [[ "$x" == "y" ]] && nvim $@ || command vi $@
}

# Dialog before doing stupid stuff
function git() {
    confirm=0

    # confirm before doing hard resets
    if [[ "$1" == "reset" ]] && [[ "$2" == "--hard" ]]; then
        confirm=1
    fi

    if [[ $confirm -eq 1 ]]; then
        echo "Are you being retarted? Press any key to continue..."
        read -k1 -s
    fi

    command git $@
}

alias vim="nvim"

# YYYYMMDDHHMMSS
alias timestamp="date '+%F%T' | tr -d ':-'"
# seconds since epoch (unix)
alias utimestamp="date '+%s'"

# neovim nightly
alias nightly-build="cd ~/build/neovim && git checkout master && git pull && make distclean && make CMAKE_BUILD_TYPE=Release && sudo make install"
