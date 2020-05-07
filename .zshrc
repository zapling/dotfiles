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

# Disable "exit" command for dropdown terminals
protectDropdownTerminal

export PATH=~/.local/bin/personal:$PATH
export PATH=~/go/bin:$PATH

# Alias
alias ssh="kitty +kitten ssh $1"
alias ss="echo Syncing to stage; sync-stage"
alias india="echo `TZ=":Asia/Kolkata" date +"%H:%M"`"
