local null_ls = require("null-ls")
local Job = require'plenary.job'
local arthur = require('zapling.lsp.null_ls_arthur_lint')

local M = {}

M.config = {
    sources = {
        arthur.null_ls_diagnostics_go_lint("netscape"),
        null_ls.builtins.diagnostics.golangci_lint.with({
            args = {
                "run",
                "--fix=false",
                "--build-tags=integration_test",
                "--out-format=json",
                "$DIRNAME",
                "--path-prefix",
                "$ROOT"
            },
            runtime_condition = function()
                return not vim.g.arthur_diagnostics_go_lint_loaded
            end
        }),

        -- shell / bash
        null_ls.builtins.diagnostics.shellcheck,

        -- typescript
        -- null_ls.builtins.formatting.prettierd, -- sometimes I need this instead of eslint_d bellow :/
        null_ls.builtins.formatting.eslint_d.with({
            on_attach = function()
                Job:new({command = 'eslint_d', args = {'restart'}}):sync()
            end,
        }),

        null_ls.builtins.diagnostics.eslint_d.with({
            on_attach = function()
                Job:new({command = 'eslint_d', args = {'restart'}}):sync()
            end,
            condition = function(utils)
                return utils.root_has_file({".eslintrc"})
            end,
        }),
        null_ls.builtins.code_actions.eslint_d,
    }
}

return M
