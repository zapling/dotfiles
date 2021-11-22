local cmp = require('cmp')

cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer", keyword_length = 5},
        { name = 'orgmode'},
        { name = "path" },
        -- { name = "luasnip" },
    },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        format = require("lspkind").cmp_format(
            {with_text = false, maxwidth = 50, menu = ({
                buffer = "[BUF]",
                nvim_lsp = "[LSP]",
                luasnip = "[SNIP]",
                nvim_lua = "[LUA]",
            })}
        )
    },
})
