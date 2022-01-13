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

  use 'lewis6991/impatient.nvim' -- lua speedup

  -- Core (feels like native vim functionality)
  use 'tpope/vim-commentary'           -- Toggle code comments
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- commentstring based on lang
  use 'tpope/vim-surround'             -- Edit 'surroundings'
  use 'tpope/vim-abolish'              -- Coercion, e.g 'crs' (coerce to snake_case)
  use 'tpope/vim-repeat'               -- . repetition for custom motions
  use 'FooSoft/vim-argwrap'            -- Wrap function arguments with keypress
  use 'unblevable/quick-scope'         -- f,F,t,F motion highlighting
  use 'ntpeters/vim-better-whitespace' -- show that fucking whitespace
  use 'sindrets/winshift.nvim'         -- move windows around easily

  -- Git
  -- use 'TimUntersberger/neogit'
  -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'tpope/vim-fugitive'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

  -- Theme and styling
  use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use {'nvim-lualine/lualine.nvim'}

  -- Syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- the good stuff
  use 'kyazdani42/nvim-web-devicons'   -- note: requires patched fonts

  -- Language Server Protocol
  use 'neovim/nvim-lspconfig' -- config helper

  -- Snippets
  use 'L3MON4D3/LuaSnip'

  -- Completion
  use 'hrsh7th/nvim-cmp'         -- auto completion
  use 'hrsh7th/cmp-buffer'       -- source buffers
  use 'hrsh7th/cmp-path'         -- source path
  use 'hrsh7th/cmp-nvim-lua'     -- source nvim lua
  use 'hrsh7th/cmp-nvim-lsp'     -- source nvim lsp
  -- use 'saadparwaiz1/cmp_luasnip' -- source luasnips
  use 'onsails/lspkind-nvim'     -- fancy icons for completion

  -- Search / Navigation
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}

  -- Misc
  -- use {'antoinemadec/FixCursorHold.nvim', run = function() vim.g.curshold_updatime = 1000 end}
  use 'folke/zen-mode.nvim'
  use 'zapling/vim-go-utils'
  -- use 'itchyny/calendar.vim'

  -- Org
  -- use 'kristijanhusak/orgmode.nvim'
  -- use 'akinsho/org-bullets.nvim'
end)
