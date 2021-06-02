-- Packer install path
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require('packer')
local util = require('packer.util')

-- [ ===== Plugins ===== ]
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-fugitive'              -- Git integration
  use 'airblade/vim-gitgutter'          -- Git annotations
  use 'ntpeters/vim-better-whitespace'  -- See annoying whitespace
  use 'joom/vim-commentary'             -- Toggle code comments
  use 'tpope/vim-surround'              -- Edit 'surroundings'
  use 'tpope/vim-repeat'                -- . repetition for custom motions
  use 'FooSoft/vim-argwrap'             -- Wrap function arguments with keypress
  use 'unblevable/quick-scope'          -- f,F,t,F motion highlighting

  -- gruvbox beauty
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- neovim 0.5 goodies, boi have we waited
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- treesitter helper
  use 'neovim/nvim-lspconfig' -- lsp config helper
  use 'hrsh7th/nvim-compe' -- lsp auto completion

end)
