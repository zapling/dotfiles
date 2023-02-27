local M = {}

M.init = function()
    vim.api.nvim_command([[
    augroup QUICKSCOPE_COLORS
        autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
        autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    augroup END
    ]])
    -- Only active if key pressed
    vim.g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}
end

return M
