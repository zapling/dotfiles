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

local function get_substr(text, pattern)
    local i, j = string.find(text, pattern)

    if not i then
        return ''
    end

    return text:sub(i, j)
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

local function show_file_in_gitlab()
    local filepath = vim.fn.expand('%')
    local linenum = vim.fn.line('.')

    local origin = nil
    Job:new({
      command = 'git',
      args = { 'config', '--get', 'remote.origin.url' },
      on_exit = function(j, return_val)
        if return_val ~= 0 then
            return
        end

        origin = j:result()[1]
      end,
    }):sync()

    if origin == nil then
        print("Not in a git repo")
        return
    end

    local host = get_substr(origin, "@.+:")
    local namespace = get_substr(origin, ":.+/")
    local repo = get_substr(origin, "/.+%.git")

    if host == "" or namespace == "" or repo == "" then
        return ""
    end

    host = host:sub(2, host:len()-1)                -- remove starting "@" and ending ":"
    namespace = namespace:sub(2, namespace:len()-1) -- remove starting ":" and ending "/"
    repo = repo:sub(2, repo:len()-4)                -- remove starting "/" and ending ".git"

    local head_sha1 = nil
    Job:new({
      command = 'git',
      args = { 'rev-parse', 'HEAD'},
      on_exit = function(j, return_val)
        if return_val ~= 0 then
            return
        end

        head_sha1 = j:result()[1]
      end,
    }):sync()

    local link = 'https://' .. host .. '/' .. namespace .. '/' .. repo

    if string.find(host, "gitlab") then
        link = link .. '/-'
    end

    link = link .. '/tree/' .. head_sha1 .. '/'
    link = link .. filepath .. '#L' .. linenum

    Job:new({command = 'xdg-open', args = { link }}):sync()
end

vim.api.nvim_create_user_command('Gitrebase', git_rebase_current_branch, {})
vim.api.nvim_create_user_command('GitOpen', show_file_in_gitlab, {})
vim.api.nvim_create_user_command('UUIDGen', insert_uuid, {})
vim.api.nvim_create_user_command('TimestampUTC', insert_timestamp, {})
