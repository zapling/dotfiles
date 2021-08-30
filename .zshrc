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

alias vim="nvim"

# YYYYMMDDHHMMSS
alias timestamp="date '+%F%T' | tr -d ':-'"
# seconds since epoch (unix)
alias utimestamp="date '+%s'"

# neovim nightly
alias nightly-build="cd ~/build/neovim && git checkout master && git pull && make distclean && make CMAKE_BUILD_TYPE=Release && sudo make install"
