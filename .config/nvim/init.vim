" =============================================================================================== "
" neovim config
" github.com/zapling
" =============================================================================================== "

" =============================================================================================== "
" Plugins
" =============================================================================================== "

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " Search
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'                          " Statusbar
Plug 'preservim/nerdtree'                             " File tree
Plug 'https://github.com/airblade/vim-gitgutter'      " Git annotations
Plug 'scrooloose/syntastic'                           " Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " Conquer of Completion
Plug 'skywind3000/asyncrun.vim'                       " Run scripts async

Plug 'joom/vim-commentary'                            " Toggle comment
Plug 'duff/vim-trailing-whitespace'                   " See trailing whitespace
Plug 'editorconfig/editorconfig-vim'                  " Editor config
Plug 'tpope/vim-surround'                             " Edit 'surroundings'

"Plug 'StanAngeloff/php.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }    " Golang

Plug 'morhetz/gruvbox'

call plug#end()

" =============================================================================================== "
" Commands
" =============================================================================================== "

command! Reload :so ~/.config/nvim/init.vim
command! Tags :AsyncRun php ~/build/phpctags -R=true --kinds=+cfi-vj

" =============================================================================================== "
" Settings
" =============================================================================================== "

set nocompatible
set updatetime=100
set number relativenumber
set shellcmdflag=-ic

""" dirs
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

""" text / tabs
set textwidth   =100
set colorcolumn =100
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab

""" indentation
set smartindent

""" search
set incsearch
set ignorecase
set smartcase

""" wrap lines
set wrap
set showbreak=>\ \ \

""" ui
" set laststatus=2
" set completeopt+=menuone
" set shortmess+=c
set noshowmode
syntax enable
colorscheme gruvbox

" =============================================================================================== "
" Plugin settings
" =============================================================================================== "

let g:lightline = {
  \     'colorscheme': 'gruvbox',
  \ }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

let g:asyncrun_open = 6

" =============================================================================================== "
" Keybinds
" =============================================================================================== "

nnoremap <CR> :noh<CR>

nnoremap <Backspace> <Nop>
map <Backspace> <leader>

map <leader>p :GFiles<CR>
map <leader>P :Files<CR>

map <leader>b :NERDTreeToggle<CR>
map <leader>B :NERDTreeFind<CR>

" =============================================================================================== "
" Languages
" =============================================================================================== "

" au BufWritePost *.php silent! !eval 'ctags -R --languages=PHP --tag-relative=yes
"     \ --langmap=php:.engine.inc.module.theme.install.php --PHP-kinds=+cfi-vj'

