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

call plug#end()

"""""""""""""
" KEY BINDS "
"""""""""""""

" clear search highlighting
nnoremap <esc> :noh<cr>

" fzf - fuzzy finder
map ; :Files<CR>

""""""
" UI "
""""""

" disable vi compatibility
set nocompatible

" show the filename in the window titlebar
set title

" set encoding
set encoding=utf-8

" directores for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

" display incomplete commands at the bottom
"set showcmd

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

" make laggy connections work faster
set ttyfast

" let vim open up to 100 tabs at once
set tabpagemax=100

" case-insensitive filename completion
set wildignorecase

"""""""""""""
" Searching "
"""""""""""""

set hlsearch "when there is a previous search pattern, highlight all its matches
set incsearch "while typing a search command, show immediately where the so far typed pattern matches
set ignorecase "ignore case in search patterns
set smartcase "override the 'ignorecase' option if the search pattern contains uppercase characters
set gdefault "imply global for new searches

"""""""""""""
" Indenting "
"""""""""""""

" When auto-indenting, use the indenting format of the previous line
set copyindent
" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
" space at the start of the line.
set smarttab
" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command)
set autoindent
" Automatically inserts one extra level of indentation in some cases, and works
" for C-like files
set smartindent

"""""""""
" Theme "
"""""""""

syntax enable
colorscheme onedark

" Lightline One Dark theme
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

"""""""""""""""""""""
" Language-Specific "
"""""""""""""""""""""

filetype plugin indent on

" JSON Syntax highlighting
au BufNewFile,BufRead *.json set ft=json syntax=javascript

"""""""""
" FIXES "
"""""""""

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
