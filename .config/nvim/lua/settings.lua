-- globals

vim.o.updatetime = 100
vim.o.backupdir = os.getenv('HOME') .. '/.vim/backup'
vim.o.directory = os.getenv('HOME') .. '/.vim/backupf'

vim.o.incsearch  = true
vim.o.ignorecase = true
vim.o.smartcase  = true

vim.o.inccommand = 'nosplit' -- see substitute result as you type
vim.o.completeopt = "menuone,noselect" -- needed for nvim-compe

--vim.o.showmode = false -- hide current mode

-- theme stuff

vim.api.nvim_command([[
augroup QUICKSCOPE_COLORS
autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
]])

-- vim.g['gruvbox_contrast_dark'] = 'hard'
vim.g['gruvbox_invert_selection'] = 0

vim.o.termguicolors = true -- enable truecolors (requires compatible terminal)
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- window-local

vim.wo.relativenumber = true -- use releative numbers
vim.wo.number         = true -- but show current line number
vim.wo.wrap           = false -- never render lines as wrapped

vim.wo.colorcolumn = '100' -- 100 chars line indicator

-- buffer
vim.bo.textwidth = 0 -- never auto break lines when typing


vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
-- vim.bo.shiftwidth  = 4 does not work?
vim.api.nvim_command('set shiftwidth=4')
vim.bo.expandtab = true
vim.bo.smartindent = true
