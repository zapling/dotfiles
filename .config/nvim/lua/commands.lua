vim.cmd[[
    command! -range TmuxRun :silent '<,'>w !tmux-run
]]
