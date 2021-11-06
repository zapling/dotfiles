-- Theme [[
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

-- ]]

-- Plugin options [[

-- Quickscope, only active if key pressed
vim.g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}

-- Whitespace highlight
vim.g['better_whitespace_guicolor'] = 'Red'

-- ]]

vim.opt.updatetime = 100
vim.opt.backupdir = os.getenv('HOME') .. '/.vim/backup'
vim.opt.directory = os.getenv('HOME') .. '/.vim/backupf'

vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.inccommand = 'nosplit' -- see substitute result as you type
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- needed for nvim-compe

vim.opt.showmode = false -- hide current mode

vim.opt.relativenumber = true -- use releative numbers
vim.opt.number         = true -- but show current line number
vim.opt.wrap           = false -- never render lines as wrapped

vim.opt.cursorline = true          -- use cursorline...
vim.opt.cursorlineopt = {'number'} -- but only highlight the linenumber

vim.opt.colorcolumn = '100' -- 100 chars line indicator

vim.opt.signcolumn = 'yes' -- always show sign column

vim.opt.textwidth = 0 -- never auto break lines when typing

vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- stolen from TJ, no you are not getting it back lol
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
