export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sunaku-zapling"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Soft disable 'exit' on dropdown terminals
protectDropdownTerminal () {
	ID=$(ps -p $$ -o ppid= | tr -d '[:space:]')
	PARAM=$(ps -p $ID o args=)
	if [[ $PARAM =~ "dropdown" ]];
	then
		alias exit="echo \"You should not exit a dropdown terminal!\" && printf 'Use \\\exit to force exit.\n'"
	fi
}

protectDropdownTerminal

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
        read -sk1
    fi

    command git $@
}

# Setup new empty dbmate migration file
function newdbmate() {
    if [[ "$1" == "" ]]; then
        echo "Supply migration name as param"
        return 1
    fi

    filename="$(timestamp)_$1.sql"

    touch $filename

    echo "-- migrate:up\n\n-- migrate:down" > $filename
}

alias vim="nvim"

# YYYYMMDDHHMMSS
alias timestamp="date '+%F%T' | tr -d ':-'"
# seconds since epoch (unix)
alias utimestamp="date '+%s'"

# neovim nightly
alias nightly-build="cd ~/build/neovim && git checkout master && git pull && make distclean && make CMAKE_BUILD_TYPE=Release && sudo make install"

# docker
alias docker-rm-all="docker ps --filter status=exited -q | xargs docker rm"
