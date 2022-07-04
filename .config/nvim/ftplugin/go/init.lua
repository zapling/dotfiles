local function quick_jump(direction)
    local search_prefix = '?'
    local regex = [[^\(func\|var\|type\|import\)]]

    if direction == 'down' then
        search_prefix = '/'
    end

    local search = search_prefix .. regex

    vim.api.nvim_exec(search, nil)
    vim.api.nvim_exec('nohls', nil)
end

vim.keymap.set('n', '[[', function() quick_jump('up') end, { silent = true, buffer = true})
vim.keymap.set('n', ']]', function() quick_jump('down') end, { silent = true, buffer = true})
