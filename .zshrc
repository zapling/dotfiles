export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sunaku-zapling"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Alias
alias ssh="kitty +kitten ssh $1"
