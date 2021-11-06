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
  },
  context_commentstring = {
    enable = true
  },
}
