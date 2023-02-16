return require("lazy").setup({
    -- Core (feels like native vim functionality)
    'tpope/vim-commentary',                        -- Toggle code comments
    'JoosepAlviste/nvim-ts-context-commentstring', -- commentstring based on lang
    'tpope/vim-surround',                          -- Edit 'surroundings'
    'tpope/vim-abolish',                           -- Coercion, e.g 'crs' (coerce to snake_case)
    'tpope/vim-repeat',                            -- . repetition for custom motions
    'FooSoft/vim-argwrap',                         -- Wrap function arguments with keypress
    'unblevable/quick-scope',                      -- f,F,t,F motion highlighting
    'ntpeters/vim-better-whitespace',              -- show that fucking whitespace
    'sindrets/winshift.nvim',                      -- move windows around easily
    'stefandtw/quickfix-reflector.vim',            -- editable quickfix window

    -- Git
    'tpope/vim-fugitive',
    {'lewis6991/gitsigns.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
    {'sindrets/diffview.nvim', dependencies = {'nvim-lua/plenary.nvim'}},

    -- Theme and styling
    'ellisonleao/gruvbox.nvim',
    'nvim-lualine/lualine.nvim',
    'kyazdani42/nvim-web-devicons', -- note: requires patched fonts

    -- Syntax
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/nvim-treesitter-context',

    -- Language Server Protocol
    'williamboman/mason.nvim', -- Package manager for LSP, linters etc
    'williamboman/mason-lspconfig.nvim',
    'jay-babu/mason-null-ls.nvim',

    'neovim/nvim-lspconfig',
    {'jose-elias-alvarez/null-ls.nvim', dependencies = {'nvim-lua/plenary.nvim'}},

    -- Snippets
    'L3MON4D3/LuaSnip', -- note: required by cmp

    -- Completion
    'hrsh7th/nvim-cmp',         -- auto completion
    'hrsh7th/cmp-buffer',       -- source buffers
    'hrsh7th/cmp-path',         -- source path
    'hrsh7th/cmp-nvim-lua',     -- source nvim lua
    'hrsh7th/cmp-nvim-lsp',    -- source nvim lsp
    -- use 'saadparwaiz1/cmp_luasnip' -- source luasnips
    'onsails/lspkind-nvim',     -- fancy icons for completion

    -- Search / Navigation
    {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}},
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- Misc
    'zapling/vim-go-utils',
    --{'zapling/reviewer.nvim', dependencies = 'nvim-lua/plenary.nvim'},
    {'zapling/plantuml.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
})
