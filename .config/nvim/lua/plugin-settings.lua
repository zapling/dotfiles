-- Whitespace highlight
vim.g['better_whitespace_guicolor'] = 'Red'

-- Quickscope, only active if key pressed
vim.g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash', 'css', 'go', 'gomod', 'html', 'javascript', 'json',
    'lua', 'python', 'typescript', 'yaml'
  },
  highlight = {
    enable = true
  }
}

-- LSP
require'lspconfig'.gopls.setup{}

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
