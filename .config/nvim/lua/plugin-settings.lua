-- Whitespace highlight
vim.g['better_whitespace_guicolor'] = 'Red'

-- Quickscope, only active if key pressed
vim.g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}

-- Git signs
require('gitsigns').setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  keymaps = {
    ['n ]c'] = { '<cmd>lua require"gitsigns".next_hunk({wrap = false})<CR>'},
    ['n [c'] = { '<cmd>lua require"gitsigns".prev_hunk({wrap = false})<CR>'},
  }
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      'bash',
      'css',
      'go',
      'gomod',
      'html',
      'javascript',
      'json',
      'lua',
      'python',
      'typescript',
      'yaml',
      'teal',
      'tsx',
      'dockerfile',
      'hcl',
  },
  highlight = {
    enable = true
  }
}

-- LSP
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}

-- disable inline diagnostic text via virtual_text
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true
}, nil)

vim.api.nvim_command('sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')

-- auto show diagnostics
vim.api.nvim_command('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})')
vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

-- use this function instead of vim.lsp.buf.hover()
-- solves issue where line_diagnostics would hide hover info because of CursorHold autocmd
function LspHover()
    vim.api.nvim_command('set eventignore=CursorHold')
    vim.lsp.buf.hover()
    vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
end

-- LSP auto completion
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    calc = false,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = false,
    ultisnips = false,
  }
}

-- Get current git branch
-- Longer branch names gets cut off in smaller windows
local function GitBranchCutOff()
    local branch = vim.api.nvim_eval('fugitive#head()')
    local max_length = 29

    local win_width = vim.api.nvim_win_get_width(0)
    if win_width <= 53 then -- dont show branch when the window is small
        return ''
    elseif win_width < 90 then -- show short branch name
        max_length = 5
    end

    if string.len(branch) > max_length + 1 then
        return string.sub(branch, 0, max_length)..'~.'
    end

    return branch
end

require('lualine').setup{
  options = {
      theme = 'gruvbox',
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
  },
  sections = {
      lualine_b = {GitBranchCutOff},
  }
}

require("winshift").setup({
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  }
})
