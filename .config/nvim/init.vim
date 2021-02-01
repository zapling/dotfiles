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
Plug 'tpope/vim-fugitive'                             " Git integration
Plug 'https://github.com/airblade/vim-gitgutter'      " Git annotations
"Plug 'dstein64/nvim-scrollview', { 'branch': 'main' } " Scroll view, requires nvim >=0.5
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " Conquer of Completion
Plug 'skywind3000/asyncrun.vim'                       " Run scripts async

Plug 'joom/vim-commentary'                            " Toggle comment
Plug 'tpope/vim-surround'                             " Edit 'surroundings'
Plug 'tpope/vim-repeat'                               " '.' repetition for surround

Plug 'duff/vim-trailing-whitespace'                   " See trailing whitespace
Plug 'editorconfig/editorconfig-vim'                  " Editor config

Plug 'zapling/vim-go-utils', {'branch': 'release'}    " Golang utils

" Plug 'yuezk/vim-js'                                   " JS
" Plug 'maxmellon/vim-jsx-pretty'                       " JSX

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'morhetz/gruvbox'                                " Theme

call plug#end()

" =============================================================================================== "
" Functions
" =============================================================================================== "

function! GoFormatOnSave()
    execute("silent! !gofmt -w %")
    execute(":e")
endfunction

function! s:ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! GitLightline()
    let l:width = winwidth(0)
    let l:branch = FugitiveHead()
    let l:max_length = 29

    if l:width <= 53
        return ''
    elseif l:width < 90
        let l:max_length = 5
    endif

    if strlen(l:branch) > l:max_length + 1
        return l:branch[0:l:max_length] . "~."
    endif

    return l:branch

    endif
endfunction

" =============================================================================================== "
" Commands
" =============================================================================================== "

command! Config :vsplit ~/.config/nvim/init.vim
command! Reload :so ~/.config/nvim/init.vim
command! Tags :AsyncRun php ~/build/phpctags -R=true --kinds=+cfi-vj
command! Sync :AsyncRun -silent ~/.local/bin/personal/./sync-stage

" =============================================================================================== "
" Settings
" =============================================================================================== "

set nocompatible
set shell=/bin/zsh
set updatetime=100
set number relativenumber

""" dirs
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

""" text / tabs
set textwidth   =100
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
set nowrap

""" ui
set colorcolumn =100
set noshowmode
syntax enable

" gruvbox tweaks, need to be set before colorscheme
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark

" =============================================================================================== "
" Autocommands
" =============================================================================================== "

augroup ZAPLING
    " remove all previous autocmd, useful when resourcing vim cfg
    autocmd!
    autocmd BufWritePost *.go call GoFormatOnSave()
    " Move this to vim-go-utils ?
    autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
augroup END

" =============================================================================================== "
" Plugin settings
" =============================================================================================== "

let g:lightline = {
  \     'colorscheme': 'gruvbox',
  \     'active': {
  \       'left': [ [ 'mode', 'paste' ],
  \                 [ 'readonly', 'filename', 'gitbranch', 'modified' ]
  \       ]
  \     },
  \     'component_function': {
  \       'gitbranch': 'GitLightline'
  \     }
  \ }

let g:coc_global_extensions = [
  \     'coc-tsserver',
  \     'coc-phpls',
  \     'coc-json',
  \]

let g:asyncrun_open = 6

set diffopt+=vertical

" =============================================================================================== "
" Keybinds
" =============================================================================================== "

nnoremap <CR> :noh<CR>

" Escape terminal mode with ESC
" tnoremap <Esc> <C-\><C-n>

nnoremap <Backspace> <Nop>
map <Backspace> <leader>

" Project search
map <leader>p :GFiles<CR>
map <leader>P :Files<CR>
map <leader>] :Rg<CR>

" Renaming
map <leader>rr <Plug>(coc-rename)
map <leader>rw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Git
map <leader>gs :G<CR>
map <leader>gf :diffget //2<CR>
map <leader>gj :diffget //3<CR>
map <leader>gb :Gblame<CR>

" Goto
map <leader>gd <Plug>(coc-definition)<CR>

" Documentation
map <leader>k :call <SID>ShowDocumentation()<CR>

" Workspace
map <leader>ws :echohl WarningMsg <bar> echo "Undefined action for the current filetype" <bar> echohl None<CR>
autocmd FileType php map <leader>ws :Sync<CR>
" map <leader>wl :GoVet<CR>
" map <leader>wt :GoCoverageToggle<CR>
