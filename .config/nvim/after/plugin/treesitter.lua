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
      'org',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  context_commentstring = {
    enable = true
  },
}

require('orgmode').setup_ts_grammar()
