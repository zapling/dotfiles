-- Orgmode parser
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

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
