local null_ls = require("null-ls")
local Job = require'plenary.job'

local sources = {
    null_ls.builtins.diagnostics.golangci_lint.with({
        args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" }
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
    null_ls.builtins.diagnostics.eslint_d,
}

null_ls.setup({
    sources = sources
})
