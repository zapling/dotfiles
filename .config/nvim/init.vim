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
Plug 'tpope/vim-fugitive'                             " Git integration
Plug 'https://github.com/airblade/vim-gitgutter'      " Git annotations
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " Conquer of Completion
Plug 'skywind3000/asyncrun.vim'                       " Run scripts async

Plug 'joom/vim-commentary'                            " Toggle comment
Plug 'duff/vim-trailing-whitespace'                   " See trailing whitespace
Plug 'editorconfig/editorconfig-vim'                  " Editor config
Plug 'tpope/vim-surround'                             " Edit 'surroundings'

" @todo Get vim-go to work with coc lang server?
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }    " Golang

Plug 'yuezk/vim-js'                                   " JS
Plug 'maxmellon/vim-jsx-pretty'                       " JSX

Plug 'morhetz/gruvbox'

call plug#end()

" =============================================================================================== "
" Functions
" =============================================================================================== "

" Jump to def
" Tries to jump with Coc, then ctags, then vims searchdecl
function! GoToDef()
    try
        call !CocAction('jumpDefinitation')
    catch /.*/
        let ret = execute("silent! normal \<C-]>")
        if ret =~ "Error"
            call searchdecl(expand('<cword>'))
        endif
    endtry
endfunction

" Show documentation, if available
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Only show git branch when space if free
function! GitLightline()
    let l:branch = FugitiveHead()
    let l:width = winwidth(0)
    if l:width > 90
        if strlen(l:branch) > 30
            return l:branch[0:29] . "~."
        endif

        return l:branch
    endif
    return ''
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

" autocmd BufWritePost *.go :silent! GoVet

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
  \     'coc-phpls',
  \     'coc-json',
  \]

let g:asyncrun_open = 6

set diffopt+=vertical

" =============================================================================================== "
" Keybinds
" =============================================================================================== "

nnoremap <CR> :noh<CR>

nnoremap <Backspace> <Nop>
map <Backspace> <leader>

" Project search
map <leader>p :GFiles<CR>
map <leader>P :Files<CR>

" File browser
map <leader>b :NERDTreeToggle<CR>
map <leader>B :NERDTreeFind<CR>

" Renaming
map <leader>rr <Plug>(coc-rename)
map <leader>rw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Git
map <leader>gs :G<CR>
map <leader>gf :diffget //2<CR>
map <leader>gj :diffget //3<CR>
map <leader>gb :Gblame<CR>

" Goto
" map <leader>gd :call GoToDef()<CR>
map <leader>gd <Plug>(coc-definition)<CR>

" Documentation
map <leader>k :call <SID>show_documentation()<CR>

" Workspace
map <leader>ws :Sync<CR>
map <leader>wl :GoVet<CR>
map <leader>wt :GoCoverageToggle<CR>
