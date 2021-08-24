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
  },
  highlight = {
    enable = true
  }
}

-- LSP
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}

-- disable inline diagnostic text via virtual_text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    }
)

vim.api.nvim_command('sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=')
vim.api.nvim_command('sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=')
vim.api.nvim_command('sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=')
vim.api.nvim_command('sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=')

-- auto show diagnostics
vim.api.nvim_command('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = true})')
vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

-- LSP auto completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
  };
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
      component_separators = {'', ''},
      section_separators = {'', ''},
  },
  sections = {
      lualine_b = {GitBranchCutOff}
  }
}
