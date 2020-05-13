"""""""""""
" PLUGINS "
"""""""""""

" plugin directory
call plug#begin('~/.vim/plugged')

call plug#end()

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

"""""""""""""""""""""
" Language-Specific "
"""""""""""""""""""""

filetype plugin indent on

" JSON Syntax highlighting
au BufNewFile,BufRead *.json set ft=json syntax=javascript
