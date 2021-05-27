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
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " Conquer of Completion
"Plug 'neoclide/coc.nvim', {'tag': 'v0.0.80'}       " Conquer of Completion
"Plug 'skywind3000/asyncrun.vim'                       " Run scripts async

Plug 'joom/vim-commentary'                            " Toggle comment
Plug 'tpope/vim-surround'                             " Edit 'surroundings'
Plug 'tpope/vim-repeat'                               " '.' repetition for surround
Plug 'FooSoft/vim-argwrap'                            " Toggle argument wraps
Plug 'unblevable/quick-scope'                         " f and F hightlighting

Plug 'duff/vim-trailing-whitespace'                   " See trailing whitespace
Plug 'editorconfig/editorconfig-vim'                  " Editor config

Plug 'zapling/vim-go-utils'                           " Golang utils

" Plug 'yuezk/vim-js'                                   " JS
" Plug 'maxmellon/vim-jsx-pretty'                       " JSX

" Database viewer
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'morhetz/gruvbox'                                " Theme

" neovim 5.0 plugins
" Plug 'dstein64/nvim-scrollview', { 'branch': 'main' } " Scroll view
" https://github.com/lukas-reineke/indent-blankline.nvim/tree/lua
" https://github.com/kevinhwang91/nvim-bqf

call plug#end()

" =============================================================================================== "
" Functions
" =============================================================================================== "

function! ToggleDBUI()
    let repoOwner = system("git config --get remote.origin.url | grep -o '\:.*\/' | tr -d ':/\n'")

    " Database cred fetching is unique to Zimpler
    if repoOwner != "Zimpler"
        execute(":DBUIToggle")
        return
    endif

    " Only fetches database creds once
    if len(g:dbs) == 0
        echo "Fetching DB configurations..."
        let service = system("basename `git rev-parse --show-toplevel` | tr -d '\n'")
        for env in ["staging", "sandbox", "production"]
            let key = service."-".env
            if !has_key(g:dbs, key)
                let cmd = "dbi " . service . " " . env . " --url | tr -d '\n'"
                let url = system(cmd)

                if strlen(url) > 0
                    let g:dbs[key] = url
                    echo "Loaded " . key . " configuration"
                endif
            endif
        endfor
    endif

    execute(":DBUIToggle")
endfunction

function! GoFormatOnSave()
    if !empty(glob("%"))
        let saved_pos = getpos(".")
        execute("silent! !gofmt -w %")
        execute(":e")
        call setpos(".", saved_pos)
    endif
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
set textwidth   =0 " never break the line for me, let me decide
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
" see substitute as you type
set inccommand=nosplit

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
    autocmd BufWritePre *.go :silent! call CocAction('runCommand', 'editor.action.organizeImport')
    autocmd BufWritePost *.go call GoFormatOnSave()
    " Move this to vim-go-utils ?
    autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
    " Add trailing , to args when wrapping in golang files
    autocmd BufNewFile,BufRead *.go let g:argwrap_tail_comma = 1
augroup END

" Quickscope colors
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
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
  \     'coc-db',
  \]

" let g:asyncrun_open = 6

set diffopt+=vertical

" Quickscope, only active when certain keys pressed
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" DBUI reset global state when loading
let g:dbs = {}

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

" Renaming (r - refactor)
map <leader>rr <Plug>(coc-rename)
map <leader>rw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Git (v - version)
map <leader>vs :G<CR>
map <leader>vf :diffget //2<CR>
map <leader>vj :diffget //3<CR>
map <leader>vb :Gblame<CR>

" Jump (g - goto)
map <leader>gd <Plug>(coc-definition)<CR>
map <leader>gj <Plug>(coc-diagnostic-next)<CR>
map <leader>gk <Plug>(coc-diagnostic-prev)<CR>
map <leader>gw :ArgWrap<CR>

" Documentation
map <leader>k :call <SID>ShowDocumentation()<CR>

" Workspace (w - workspace)
map <leader>ws :echohl WarningMsg <bar> echo "Undefined action for the current filetype" <bar> echohl None<CR>
map <leader>wo :call ToggleDBUI()<CR>
" autocmd FileType php map <leader>ws :Sync<CR>
" map <leader>wl :GoVet<CR>
" map <leader>wt :GoCoverageToggle<CR>
