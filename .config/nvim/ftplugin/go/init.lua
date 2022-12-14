local function quick_jump(direction)
    local flags = 'bz'
    local regex = [[^\\(package\\|import\\|type\\|const\\|var\\|func\\)]]

    if direction == 'down' then
        flags = ''
    end

    local command = string.format('execute search("%s", "%s")', regex, flags)

    vim.api.nvim_exec(command, nil)
end

vim.keymap.set('n', '[[', function() quick_jump('up') end, { silent = true, buffer = true})
vim.keymap.set('n', ']]', function() quick_jump('down') end, { silent = true, buffer = true})
