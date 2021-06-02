vim.api.nvim_command([[
augroup ZAPLING
autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
augroup END
]])
