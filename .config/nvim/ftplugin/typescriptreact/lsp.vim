augroup TS_LSP
    autocmd!
    autocmd BufWritePre *.ts,*.tsx :silent! lua vim.lsp.buf.formatting_sync()
augroup END
