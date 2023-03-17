local Job = require'plenary.job'

local function get_current_branch()
    local branch = nil
    Job:new({
        command = "git",
        args = { "branch", "--show-current" },
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                return
            end

            branch = j:result()[1]
        end,
    }):sync()
    return branch
end

local git_rebase_current_branch = function()
    local current_branch = get_current_branch()
    if current_branch == nil then
        return
    end

    local origin_head_branch = nil
    Job:new({
        command = "git",
        args = {"symbolic-ref", "refs/remotes/origin/HEAD"},
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                return
            end

            origin_head_branch = j:result()[1]:sub(21)
        end,
    }):sync()

    if origin_head_branch == nil then
        return
    end

    local compare = 'origin/' .. origin_head_branch .. '..' .. current_branch

    local num_commits = nil
    Job:new({
        command = "git",
        args = { "rev-list", "--count", compare },
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                return
            end

            num_commits = j:result()[1]
        end,
    }):sync()

    if num_commits == nil then
        return
    end

    local command = 'Git rebase -i HEAD~' .. num_commits

    vim.api.nvim_command(command)
end

local function insert_uuid()
    local uuid = nil
    Job:new({
        command = 'uuidgen',
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                return
            end

            uuid = j:result()[1]
        end,
    }):sync()
    vim.cmd('normal i' .. uuid)
end

local function insert_timestamp()
    local timestamp = nil
    Job:new({
        command = 'timestamp',
        args = {'utc'},
        on_exit = function(j, return_val)
            if return_val ~= 0 then
                return
            end

            timestamp = j:result()[1]
        end,
    }):sync()
    vim.cmd('normal i' .. timestamp)
end

vim.api.nvim_create_user_command('Gitrebase', git_rebase_current_branch, {})
vim.api.nvim_create_user_command('UUIDGen', insert_uuid, {})
vim.api.nvim_create_user_command('TimestampUTC', insert_timestamp, {})
