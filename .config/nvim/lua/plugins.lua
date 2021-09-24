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

  -- Core (feels like native vim functionality)
  use 'joom/vim-commentary'            -- Toggle code comments
  use 'tpope/vim-surround'             -- Edit 'surroundings'
  use 'tpope/vim-repeat'               -- . repetition for custom motions
  use 'FooSoft/vim-argwrap'            -- Wrap function arguments with keypress
  use 'unblevable/quick-scope'         -- f,F,t,F motion highlighting
  use 'ntpeters/vim-better-whitespace' -- show that fucking whitespace
  use 'sindrets/winshift.nvim'         -- move windows around easily

  -- Git
  use 'tpope/vim-fugitive'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

  -- Database viewer
  -- TODO: remove or get into workflow of using it
  use 'tpope/vim-dadbod'
  use 'kristijanhusak/vim-dadbod-ui'

  -- Theme and styling
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use {'shadmansaleh/lualine.nvim'} -- updated fork (org-maintainer afk for months)
  -- use {'hoob3rt/lualine.nvim', branch = 'shadmansaleh:master' }

  -- Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- the good stuff
  use 'kyazdani42/nvim-web-devicons'   -- note: requires patched fonts

  use 'hashivim/vim-terraform' -- HCL highlighting

  -- Language Server Protocol
  use 'neovim/nvim-lspconfig' -- config helper
  use 'hrsh7th/nvim-compe'    -- auto completion
  use 'folke/trouble.nvim'    -- better diagnostic viewer

  -- Search / Navigation
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
end)
