" https://github.com/neovim/nvim-lspconfig/issues/115
lua <<EOF
    function go_lsp_save_actions()
        if not vim.lsp.buf.server_ready() then
            return
        end

        vim.lsp.buf.formatting()
        org_imports(3000)
    end

    function org_imports(wait_ms)
        local params = vim.lsp.util.make_range_params()
        params.context = {only = {"source.organizeImports"}}
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit)
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end
EOF

augroup GO_LSP
	autocmd!
	autocmd BufWritePre *.go :silent! lua go_lsp_save_actions()
augroup END
