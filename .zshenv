export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim

export GOPATH=~/go

export PATH=/usr/local/bin:$PATH
export PATH=~/.local/bin/personal:$PATH
export PATH=~/.local/bin/work:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/.npm_global/bin:$PATH
export PATH=~/.local/bin/nvim-mason/bin:$PATH

# Override JQ colors so null values are red, works better than grey on dark background
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'

# Work
export GOPRIVATE="github.com/Zimpler/*,gitlab.zimpler.com/*"
export ARTHUR_GITCONFIG_PATH=$HOME/dotfiles/.config/git/config_work_arthur
export ARTHUR_AWS_USE_SSO=1
