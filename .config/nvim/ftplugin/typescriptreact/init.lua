local null_ls = require("null-ls")

local augroup_typescript = vim.api.nvim_create_augroup('TS_LSP', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*.ts,*.tsx',
  group = augroup_typescript,
  callback = function()
      vim.lsp.buf.format({filter = function(client) return client.name ~= "tsserver" end})
  end,
  desc = 'Format buffer before save with client NOT named tsserver',
})

vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  pattern = '*.ts,*.tsx',
  group = augroup_typescript,
  callback = function()
      local source = null_ls.get_source({
          name = "eslint_d",
          method = null_ls.methods.DIAGNOSTICS
      })[1]

      if source == nil then
          return
      end

      local namespace = require("null-ls.diagnostics").get_namespace(source.id)
      if namespace ~= nil then
          vim.diagnostic.reset(namespace)
      end
  end,
  desc = 'Reset/Clear eslint diagnostics when text is changed',
})

