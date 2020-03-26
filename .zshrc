export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sunaku-zapling"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Go path
export PATH=~/go/bin:$PATH

# Alias
alias ssh="kitty +kitten ssh $1"
alias ss="sync-stage"
