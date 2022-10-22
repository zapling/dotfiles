lua <<EOF
    function reset_eslint()
        local name_space_id = vim.api.nvim_get_namespaces()["NULL_LS_SOURCE_3"] -- this could break
        if pcall(vim.diagnostic.reset(name_space_id)) then end
    end
EOF

augroup TS_LSP
    autocmd!
    autocmd BufWritePre *.ts,*.tsx :silent! lua vim.lsp.buf.formatting_sync(nil, 3000)
    autocmd TextChanged,TextChangedI *.go :silent! lua reset_eslint()
augroup END
