augroup TS_LSP
    autocmd!
    autocmd BufWritePre *.tx,*.tsx :silent! lua vim.lsp.buf.formatting_sync()
augroup END
