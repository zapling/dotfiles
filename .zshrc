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

# function myshopDump() {
# 	stamp=$(date +%s)
# 	mysql -h hostname -Ddatabase -pPassword -uUser -e $1 | sed 's/\t/","/g;s/^/"/;s/$/"/;' > sql_dump_$stamp.csv
# 	echo "Dumped sql to: sql_dump_$stamp.csv"
# }

# Programs
# alias vim="nvim0.5 -u ~/.config/nvim/init.lua"
alias lvim="nvim0.4 -u ~/.config/nvim/init0.4.vim"
alias vim="nvim0.5"
alias vi="echo -e \"vi, did you mean vim? (y/n)\" && read -sk x && [[ \"\$x\" == \"y\" ]] && nvim || vi"
alias ssh_kitty="kitty +kitten ssh $1"

# Other
alias timestamp="date '+%F%T' | tr -d ':-'"
alias utimestamp="date '+%s'"

# neovim nightly
alias nightly-build="cd ~/build/neovim && git checkout master && git pull && make distclean && make CMAKE_BUILD_TYPE=Release && sudo make install"
