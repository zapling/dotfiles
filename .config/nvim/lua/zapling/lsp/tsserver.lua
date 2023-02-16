local M = {}

M.config = {
    flags = {
      debounce_text_changes = 150,
    },
    root_dir = require'lspconfig.util'.root_pattern("package.json"),
    -- on_attach = function(client)
    --     client.server_capabilities.documentFormattingProvider = false
    --     client.server_capabilities.documentRangeFormattingProvider = false
    -- end,
}

return M
