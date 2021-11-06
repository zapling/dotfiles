-- Auto equalize splits when Vim is resized
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- Dont highlight whitespace in the Trouble buffer
-- vim.api.nvim_command('autocmd FileType Trouble DisableWhitespace')
