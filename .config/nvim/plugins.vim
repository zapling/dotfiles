call plug#begin('~/.vim/plugged')

""" Core

" Search files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status bar
Plug 'itchyny/lightline.vim'

" File tree
Plug 'preservim/nerdtree'

" Git diff annotations
Plug 'https://github.com/airblade/vim-gitgutter'

""" Quality of life

" Toggle comments
Plug 'joom/vim-commentary'

" Show trailing whitespace
Plug 'duff/vim-trailing-whitespace'

""" Theme

" Gruvbox Theme
Plug 'morhetz/gruvbox'

call plug#end()

