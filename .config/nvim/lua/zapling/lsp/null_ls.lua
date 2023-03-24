local null_ls = require("null-ls")
local Job = require'plenary.job'

local M = {}

local zimpler_null_ls_config = {
    args = {
        "go",
        "lint",
        "netscape",
        "--",
        "--fix=false",
        "--build-tags=integration_test",
        "--out-format=json",
        "$DIRNAME",
        "--path-prefix",
        "$ROOT"
    },
}

M.config = {
    sources = {
        require("zimpler.null_ls").diagnostics_go_lint("netscape").with(zimpler_null_ls_config),
        require("zimpler.null_ls").diagnostics_go_lint("napster").with(zimpler_null_ls_config),

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
