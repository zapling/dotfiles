" https://github.com/neovim/nvim-lspconfig/issues/115
lua <<EOF
    function go_lsp_save_actions()
        if not vim.lsp.buf.server_ready() then
            return
        end

        vim.lsp.buf.format({async = true})
        org_imports(3000)
    end

    function org_imports(wait_ms)
        local params = vim.lsp.util.make_range_params()
        params.context = {only = {"source.organizeImports"}}
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end

    function go_reset_lint()
        local name_space_id = vim.api.nvim_get_namespaces()["NULL_LS_SOURCE_1"] -- this could break
        if pcall(vim.diagnostic.reset(name_space_id)) then end
    end
EOF

augroup GO_LSP
	autocmd!
	autocmd BufWritePre *.go :silent! lua go_lsp_save_actions()
    autocmd TextChanged,TextChangedI *.go :silent! lua go_reset_lint()
augroup END
