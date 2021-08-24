-- Packer install path
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- [ ===== Plugins ===== ]
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-fugitive'              -- Git integration
  use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'}
  } 					-- Git annotations
  use 'ntpeters/vim-better-whitespace'  -- See annoying whitespace
  use 'joom/vim-commentary'             -- Toggle code comments
  use 'tpope/vim-surround'              -- Edit 'surroundings'
  use 'tpope/vim-repeat'                -- . repetition for custom motions
  use 'FooSoft/vim-argwrap'             -- Wrap function arguments with keypress
  use 'unblevable/quick-scope'          -- f,F,t,F motion highlighting

  -- database viewer
  use 'tpope/vim-dadbod'
  use 'kristijanhusak/vim-dadbod-ui'

  -- theme / syntax
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use {'shadmansaleh/lualine.nvim'} -- updated fork, author seems to be inactive on the main one
  -- use {'hoob3rt/lualine.nvim', branch = 'shadmansaleh:master' }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax
  use 'kyazdani42/nvim-web-devicons'                           -- icons (requires patch fonts (Nerd fonts)

  -- language stuff
  use 'teal-language/vim-teal'
  use 'hashivim/vim-terraform'

  -- lsp
  use 'neovim/nvim-lspconfig' -- config helper
  use 'hrsh7th/nvim-compe'    -- auto completion
  use 'folke/trouble.nvim'    -- better diagnostic viewer

  -- search / navigation
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}

end)
