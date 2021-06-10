vim.opt.updatetime = 100
vim.opt.backupdir = os.getenv('HOME') .. '/.vim/backup'
vim.opt.directory = os.getenv('HOME') .. '/.vim/backupf'

vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.inccommand = 'nosplit' -- see substitute result as you type
vim.opt.completeopt = "menuone,noselect" -- needed for nvim-compe

vim.opt.showmode = false -- hide current mode

-- theme stuff

vim.api.nvim_command([[
augroup QUICKSCOPE_COLORS
autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
]])

vim.g['gruvbox_contrast_dark'] = 'hard'
vim.g['gruvbox_invert_selection'] = 0

vim.opt.termguicolors = true -- enable truecolors (requires compatible terminal)
vim.opt.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

vim.opt.relativenumber = true -- use releative numbers
vim.opt.number         = true -- but show current line number
vim.opt.wrap           = false -- never render lines as wrapped

vim.opt.colorcolumn = '100' -- 100 chars line indicator

vim.opt.signcolumn = 'yes' -- always show sign column

vim.opt.textwidth = 0 -- never auto break lines when typing

vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
