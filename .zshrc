export ZSH=$HOME/.oh-my-zsh

HISTORY_IGNORE="(jwt-decode*|systemctl poweroff)"

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

    if [[ "$1" == "push" ]] && [[ "$2" == "-f" ]]; then
        confirm=1
    fi

    if [[ "$1" == "clean" ]] && [[ "$2" == "-fd" ]]; then
        confirm=1
    fi

    if [[ $confirm -eq 1 ]]; then
        echo "Are you being retarded? Press any key to continue..."
        read -sk1
    fi

    command git $@
}

function git-checkout-date () {
    date_input=$1
    time_input=${2:-00:00:00}
    branch_input=${3:-main}

    if [[ "$date_input" == "" ]]; then
        echo "git-checkout-date <date> [time] [branch]"
        return 1
    fi

    git checkout "${branch}@{${date_input} ${time_input}}"
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

function seer() {
    if [[ "$1" == "" ]]; then
        arthur deploy seer -s netscape
        return
    fi

    arthur deploy seer -s "$1"
}

alias j="journal e"
alias vim="nvim"
alias gom="go mod tidy && go mod vendor"
alias copy="xclip -sel clip"
alias task="go-task"
alias lint="arthur go lint netscape -- --fix=false"
