export ZSH=$HOME/.oh-my-zsh

HISTORY_IGNORE="jwt-decode*"

ZSH_THEME="sunaku-zapling"

plugins=(git ssh-agent)

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

function killall() {
    if [[ "$1" == "firefox" ]]; then
        command killall /usr/lib/firefox/firefox
        return
    fi

    command killall $@
}

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

function docker() {
    if [[ "$1" == "kill-all" || "$1" == "stop-all" ]]; then
        containers=($(docker ps -q))
        if [[ "$containers" == "" ]]; then
            echo "Nothing to stop"
            return 1
        fi

        command docker kill $containers
        return
    fi

    if [[ "$1" == "rm-all" ]]; then
        command docker ps --filter status=exited -q | xargs docker rm
        return
    fi

    command docker $@
}

function arthur() {
    ARTHUR_AUTO_UPDATE=true command arthur $@
}

alias j="journal e"

alias vim="nvim"

# YYYYMMDDHHMMSS
alias timestamp="date '+%F%T' | tr -d ':-'"
# seconds since epoch (unix)
alias utimestamp="date '+%s'"

alias gom="go mod tidy && go mod vendor"

alias status="arthur seer"
