-- Theme [[

vim.g['gruvbox_contrast_dark'] = 'hard'
vim.g['gruvbox_invert_selection'] = 0

vim.opt.termguicolors = true -- enable truecolors (requires compatible terminal)
vim.opt.background = 'dark'

require("gruvbox").setup({
    -- TODO: not needed anymore?
    overrides = {
        -- GitSignsChange = {fg = require("gruvbox.palette").bright_aqua},
        -- Delimiter = {fg = require("gruvbox.palette").bright_orange},
        Operator = {fg = "#f2e5bc", italic = false, bold = false},
        ["@variable"] = { fg = "#f2e5bc" },
    },
    italic = {
        strings = false,
        operators = false,
        comments = false
    },
    contrast = "hard",
})

vim.cmd([[colorscheme gruvbox]])

-- ]]

-- Plugin options [[

-- Whitespace highlight
vim.g['better_whitespace_guicolor'] = 'Red'

-- ]]

vim.cmd([[ set mouse= ]])

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

vim.cmd('language en_US.utf8')
