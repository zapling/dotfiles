vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    float = {
        source = 'if_many',
        focusable = false,
    },
}, nil)

vim.api.nvim_command('sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=')
vim.api.nvim_command('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')

vim.api.nvim_command('autocmd CursorHold * lua vim.diagnostic.open_float(nil, {scope = \'line\', close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}})')
vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

-- use this function instead of vim.lsp.buf.hover()
-- solves issue where line_diagnostics would hide hover info because of CursorHold autocmd
function LspHover()
    vim.api.nvim_command('set eventignore=CursorHold')
    vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
    vim.lsp.buf.hover()
end

function LspDiagnosticsFocus()
    vim.api.nvim_command('set eventignore=WinLeave')
    vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
    vim.diagnostic.open_float(nil, {focusable = true, scope = 'line', close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}})
end

-- WIP! This didn't work out as planned for all cases, jump manually for now
-- convient helper for getting cursor bufnr, colnr, and linenr
-- local function getCursorPos()
--     return {
--         buf = vim.api.nvim_eval("bufnr('%')"),
--         col = vim.api.nvim_eval("col('.')"),
--         line = vim.api.nvim_eval("line('.')"),
--     }
-- end
-- Probably the most useful function for LSP, at least for Golang.
-- Tries to jump to the lsp implementation first, but if ther cursor
-- didn't move (no implementation found) then we jump to the lsp definition.
-- function LspJump()
--     local cb = getCursorPos()

--     require'telescope.builtin'.lsp_implementations()

--     local ca = getCursorPos()

--     if cb.buf == ca.buf or cb.col == ca.col or cb.line == ca.line then
--         require'telescope.builtin'.lsp_definitions()
--     end
-- end
--

