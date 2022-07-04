local function quick_jump(direction)
    local search_prefix = '?'
    local regex = [[^\(package\|import\|type\|const\|var\|func\)]]

    if direction == 'down' then
        search_prefix = '/'
    end

    local search = search_prefix .. regex .. search_prefix

    vim.api.nvim_exec('silent ' .. search, nil)
    vim.api.nvim_exec('silent nohls', nil)
    vim.api.nvim_exec('norm 0', nil)
end

vim.keymap.set('n', '[[', function() quick_jump('up') end, { silent = true, buffer = true})
vim.keymap.set('n', ']]', function() quick_jump('down') end, { silent = true, buffer = true})
