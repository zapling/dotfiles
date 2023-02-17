local helper = require("null-ls.helpers")
local methods = require("null-ls.methods")
local log = require("null-ls.logger")
local Job = require("plenary.job")

local DIAGNOSTICS_ON_SAVE = methods.internal.DIAGNOSTICS_ON_SAVE

local function get_source(team_name)
    return helper.make_builtin({
    name = "arthur go lint",
    meta = {
        url = "https://gitlab.zimpler.com/platform/arthur",
        description = "golangci-lint via arthur to handle configs",
    },
    method = DIAGNOSTICS_ON_SAVE,
    filetypes = { "go" },
    generator_opts = {
        command = "go",
        to_stdin = true,
        from_stderr = false,
        ignore_stderr = true,
        args = {
            "run",
            "/home/andreas/R/arthur/cmd/arthur/main.go",
            "go",
            "lint",
            team_name,
            "--fix=false",
            "--build-tags=integration_test",
            "--out-format=json",
            "$DIRNAME",
            "--path-prefix",
            "$ROOT"
        },
        format = "json",
        check_exit_code = function(code)
            return code <= 2
        end,
        on_output = function(params)
            local diags = {}
            if params.output["Report"] and params.output["Report"]["Error"] then
                log:warn(params.output["Report"]["Error"])
                return diags
            end
            local issues = params.output["Issues"]
            if type(issues) == "table" then
                for _, d in ipairs(issues) do
                    if d.Pos.Filename == params.bufname then
                        table.insert(diags, {
                            source = string.format("golangci-lint:%s", d.FromLinter),
                            row = d.Pos.Line,
                            col = d.Pos.Column,
                            message = d.Text,
                            severity = helper.diagnostics.severities["warning"],
                        })
                    end
                end
            end
            return diags
        end,
        runtime_condition = function()
            local remote_origin_url = nil

            Job:new({
              command = 'git',
              args = { 'config', '--get', 'remote.origin.url' },
              on_exit = function(j, return_val)
                if return_val ~= 0 then
                    return
                end

                remote_origin_url = j:result()[1]
              end,
            }):sync()

            if remote_origin_url == nil then
                return false
            end

            local function get_substr(text, pattern)
                local i, j = string.find(text, pattern)

                if not i then
                    return ''
                end

                return text:sub(i, j)
            end

            local namespace = get_substr(remote_origin_url, ":.+/")
            if namespace == "" then
                return false
            end

            namespace = namespace:sub(2, namespace:len()-1)

            if namespace ~= team_name then
                return false
            end

            vim.g.arthur_diagnostics_go_lint_loaded = true
            return true
        end,
    },
    factory = helper.generator_factory,
})
end

local M = {}

-- null-ls diagnostics source for golangci-lint via "arthur go lint"
--
-- Only attaches to the buffer if the inside a git repository owned by the
-- team name provided.
--
-- When attached to a buffer a global variable 'arthur_diagnostics_go_lint_loaded' if set to true.
-- You can use this variable to determine if normal golangci-lint should load or not.
-- E.g
-- null_ls.builtins.diagnostics.golangci_lint.with({
--     runtime_condition = function()
--         return not vim.g.arthur_diagnostics_go_lint_loaded
--     end
-- }),
M.null_ls_diagnostics_go_lint = function(team_name)
    return get_source(team_name)
end

return M
