-- Whitespace highlight
-- vim.g['better_whitespace_guicolor'] = 'Red'

-- Quickscope, only active if key pressed
vim.g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}

-- Git signs
require('gitsigns').setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  keymaps = {
    ['n ]c'] = { '<cmd>lua require"gitsigns".next_hunk({wrap = false})<CR>'},
    ['n [c'] = { '<cmd>lua require"gitsigns".prev_hunk({wrap = false})<CR>'},
  }
}

-- Treesitter
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

-- LSP
require'lspconfig'.gopls.setup{
    handlers = {
        ['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                update_in_insert = false,
            }
        ),
    },
}
require'lspconfig'.tsserver.setup{}

-- disable inline diagnostic text via virtual_text
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    float = {
        source = 'if_many',
        focusable = false,
    },
}, nil)

vim.api.nvim_command('sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')

-- auto show diagnostics
vim.api.nvim_command('autocmd CursorHold * lua vim.diagnostic.open_float(nil, {scope = \'line\', close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}})')
vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

-- WIP! This didn't work out as planned for all cases, jump manually for now
-- convient helper for getting cursor bufnr, colnr, and linenr
-- local function getCursorPos()
--     return {
--         buf = vim.api.nvim_eval("bufnr('%')"),
--         col = vim.api.nvim_eval("col('.')"),
--         line = vim.api.nvim_eval("line('.')"),
--     }
-- end
-- Probably the most useful function for LSP, at least for Golang.
-- Tries to jump to the lsp implementation first, but if ther cursor
-- didn't move (no implementation found) then we jump to the lsp definition.
-- function LspJump()
--     local cb = getCursorPos()

--     require'telescope.builtin'.lsp_implementations()

--     local ca = getCursorPos()

--     if cb.buf == ca.buf or cb.col == ca.col or cb.line == ca.line then
--         require'telescope.builtin'.lsp_definitions()
--     end
-- end

-- use this function instead of vim.lsp.buf.hover()
-- solves issue where line_diagnostics would hide hover info because of CursorHold autocmd
function LspHover()
    vim.api.nvim_command('set eventignore=CursorHold')
    vim.lsp.buf.hover()
    vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
end


-- function LspDiagnostics(focusable)
--     function open(focus)
--         vim.diagnostic.open_float(nil, {focusable = focus, scope = 'line', close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}})
--     end

--     if not focusable then
--         open(false)
--         return
--     end

--     if vim.F.npcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_preview") then
--         local floatingWinNr = vim.api.nvim_buf_get_var(0, "lsp_floating_preview")

--         if vim.api.nvim_win_is_valid(floatingWinNr) then
--             vim.api.nvim_set_current_win(floatingWinNr)
--         else
--             open(true)
--             return
--         end
--     else
--         open(true)
--     end
-- end

local cmp = require'cmp'
cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer"},
        { name = "path" },
        -- { name = "luasnip" },
    },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        format = require("lspkind").cmp_format(
            {with_text = false, maxwidth = 50, menu = ({
                buffer = "[BUF]",
                nvim_lsp = "[LSP]",
                luasnip = "[SNIP]",
                nvim_lua = "[LUA]",
            })}
        )
    },
})

-- Get current git branch
-- Longer branch names gets cut off in smaller windows
local function GitBranchCutOff()
    local branch = vim.api.nvim_eval('fugitive#head()')
    local max_length = 29

    local win_width = vim.api.nvim_win_get_width(0)
    if win_width <= 53 then -- dont show branch when the window is small
        return ''
    elseif win_width < 90 then -- show short branch name
        max_length = 5
    end

    if string.len(branch) > max_length + 1 then
        return string.sub(branch, 0, max_length)..'~.'
    end

    return branch
end

require('lualine').setup{
  options = {
      theme = 'gruvbox',
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
  },
  sections = {
      lualine_b = {GitBranchCutOff},
  }
}

require("winshift").setup({
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  }
})


-- local ls = require "luasnip"


-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local l = require("luasnip.extras").lambda
-- local r = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

-- local function copy(args)
-- 	return args[1]
-- end

-- local shortcut = function(val)
--   if type(val) == "string" then
--     return { t { val }, i(0) }
--   end

--   if type(val) == "table" then
--     for k, v in ipairs(val) do
--       if type(v) == "string" then
--         val[k] = t { v }
--       end
--     end
--   end

--   return val
-- end

-- local make = function(tbl)
--   local result = {}
--   for k, v in pairs(tbl) do
--     table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
--   end

--   return result
-- end

-- ls.config.set_config {
--   history = true,
--   updateevents = "TextChanged,TextChangedI",
-- }

-- ls.snippets.go = make {
--     main = {
--         t { "func main() {", "\t" },
--         i(0),
--         t { "", "}" },
--     },
-- }
