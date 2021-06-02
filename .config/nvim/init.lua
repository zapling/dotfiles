--[[ ========================
  neovim 0.5 config
  github.com/zapling
======================== --]]

require('plugins')          -- install/load plugins
require('settings')         -- vim settings
require('plugin-settings')  -- plugin specific settings
require('autocmd')          -- custom auto commands

--[[ ===== Keymaps ==== -- ]]

local map = vim.api.nvim_set_keymap

-- rebind leader key
map('n', '<Backspace>', '<Nop>', {noremap = true})
map('n', '<Backspace>', '<Leader>', {})

map('n', '<CR>', ':noh<CR>', {noremap = true})

-- git
map('', '<Leader>vs', ':G<CR>', {})
map('', '<Leader>vf', ':diffget //2<CR>', {})
map('', '<Leader>vj', ':diffget //3<CR>', {})
map('', '<Leader>vb', ':Gblame<CR>', {})

-- argwrap
map('', '<Leader>gw', ':ArgWrap<CR>', {})

-- lsp
map('', '<Leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
map('', '<Leader>gj', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {silent = true})
map('', '<Leader>gk', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {silent = true})
map('', '<Leader>k', '<Cmd>lua vim.lsp.buf.hover()<CR>', {silent = true})
map('', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {silent = true})

-- lsp auto complete
map('i', '<CR>', 'compe#confirm("<CR>")', {silent = true, expr = true})
map('i', '<C-space>', 'compe#complete()', {silent = true, expr = true})
