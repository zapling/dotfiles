--[[ ========================
  neovim 0.5 config
  github.com/zapling
======================== --]]

require('plugins')          -- install/load plugins
require('settings')         -- vim settings
require('plugin-settings')  -- plugin specific settings
require('autocmd')          -- auto commands

--[[ ===== Keymaps ==== -- ]]

local map = vim.api.nvim_set_keymap

-- basic rebinds
map('n', '<Backspace>', '<Nop>', {noremap = true})
map('n', '<Backspace>', '<Leader>', {})
map('n', '<CR>', ':noh<CR>', {noremap = true})

-- git
map('', '<Leader>vs', ':G<CR>', {})
map('', '<Leader>vf', ':diffget //2<CR>', {})
map('', '<Leader>vj', ':diffget //3<CR>', {})
map('', '<Leader>vb', ':Git blame<CR>', {})

-- argwrap
-- TODO: can this be solved by Treesitter?
map('', '<Leader>gw', ':ArgWrap<CR>', {})

-- lsp
map('', '<Leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
map('', '<Leader>gj', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {silent = true})
map('', '<Leader>gk', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {silent = true})
map('', '<Leader>d', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<CR>', {silent = true})
map('', '<Leader>k', '<Cmd>lua vim.lsp.buf.hover()<CR>', {silent = true})
map('', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', {silent = true})
map('', '<Leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', {silent = true})

-- lsp auto complete
map('i', '<CR>', 'compe#confirm("<CR>")', {silent = true, expr = true})
map('i', '<C-space>', 'compe#complete()', {silent = true, expr = true})

-- telescope
map('', '<Leader>p', '<Cmd>lua require(\'telescope.builtin\').find_files({hidden = true})<CR>', {})
map('', '<Leader>P', '<Cmd>Telescope file_browser<CR>', {})
map('', '<Leader>gp', '<Cmd>Telescope git_status<CR>', {})
map('', '<Leader>gP', '<Cmd>Telescope git_commits<CR>', {})
map('', '<Leader>]', '<Cmd>Telescope live_grep<CR>', {})
