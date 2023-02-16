local Job = require'plenary.job'
local protocol = require 'vim.lsp.protocol'

-- Wrapper around gopls lsp handler 'window/LogMessage'
-- Attempts to solve 'inconsistent vendoring' errors by running 'go mod vendor' in an async job.
-- Triggers only once in a 60 seconds window to allow the job to be completed.
local lastVendoringError = 0
local goplsLogMessageWrapper = function(_, result, ctx, _)
    local now = os.time()

    if result.type == protocol.MessageType.Error then
        local delta = lastVendoringError - now
        if string.find(result.message, "inconsistent vendoring") and lastVendoringError == 0 or delta >= 60 then
            lastVendoringError = now

            Job:new({
                command = 'go',
                args = {'mod', 'vendor'},
                cwd = vim.fn.getcwd(),
                on_exit = function(j, return_val)
                    vim.schedule(function()
                        vim.notify(
                            "Automatically ran 'go mod vendor' to fix inconsistent vendoring",
                            vim.log.levels.WARN
                        )
                    end)
                end,
            }):sync()
        end
    end

    return vim.lsp.handlers["window/logMessage"](_, result, ctx, _)
end

local M = {}

M.config = {
    handlers = {
        ['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                update_in_insert = false,
            }
        ),
        ['window/logMessage'] = goplsLogMessageWrapper,
    },
    settings = {
        gopls = {
            buildFlags = {"-tags=integration_test"}
        }
    }
}

return M
