local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.diagnostics.golangci_lint.with({
        args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" }
    })
}

null_ls.setup({
    debug = true,
    sources = sources
})
