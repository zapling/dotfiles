"""""""""""
" PLUGINS "
"""""""""""

" plugin directory
call plug#begin('~/.vim/plugged')

" Atom One Dark Theme
Plug 'https://github.com/joshdick/onedark.vim'

" fzf - Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Lightline statusbar
Plug 'itchyny/lightline.vim'

" Nerdtree
Plug 'preservim/nerdtree'

" Git gutter
Plug 'https://github.com/airblade/vim-gitgutter'

" Dev icons
Plug 'ryanoasis/vim-devicons'
call plug#end()

"""""""""""""""""""
" CUSTOM COMMANDS "
"""""""""""""""""""

command! Reload :so ~/.config/nvim/init.vim

""""""""""""
" KEYBINDS "
""""""""""""

" clear search highlighting
nnoremap <CR> :noh<CR>

" Search files
map ; :Files<CR>
" File tree
map ' :NERDTreeToggle<CR>

""""""
" UI "
""""""

" disable vi compatibility
set nocompatible

" directores for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

" line numbers
set number

" text wrapping
set textwidth=80
set colorcolumn=80

" status bar
set laststatus=2

" show '>   ' at the beginning of lines that are automatically wrapped
set showbreak=>\ \ \ 

" enable completion
set ofu=syntaxcomplete#Complete

" let vim open up to 100 tabs at once
set tabpagemax=100

"""""""""""""
" Searching "
"""""""""""""

set incsearch "while typing a search command, show immediately where the so far typed pattern matches
set ignorecase "ignore case in search patterns
set smartcase "override the 'ignorecase' option if the search pattern contains uppercase characters
set gdefault "imply global for new searches

"""""""""
" Theme "
"""""""""

syntax enable
colorscheme onedark

" Lightline One Dark theme
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" Terminal true color
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

