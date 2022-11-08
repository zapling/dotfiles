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

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = {
        default = {
            'class',
            'function',
            'method',
        },
    },
}
