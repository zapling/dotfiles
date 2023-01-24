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

    if [[ $confirm -eq 1 ]]; then
        echo "Are you being retarted? Press any key to continue..."
        read -sk1
    fi

    command git $@
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

function timestamp() {
    cmd=$1 ; shift > /dev/null 2>&1
    case "$cmd" in
        # YYYYMMDDHHMMSS (local time)
        "")
            date '+%F%T' | tr -d ':-'
            ;;
        # seconds since epoch (unix)
        "unix")
            date "+%s"
            ;;
        # yyyy-mm-ddThh:mm:ss.mms+00:00 (utc)
        "utc")
            date '+%FT%T.%N+00:00' --utc
            ;;
        *)
            echo "Unsupported option"
            return 1
    esac
}

alias j="journal e"
alias vim="nvim"
alias gom="go mod tidy && go mod vendor"
alias copy="xclip -sel clip"
alias seer="arthur deploy seer"
alias task="go-task"
