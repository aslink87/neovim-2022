-- Null-LS
require('null-ls').setup ({
  sources = {
    -- Formatters
    require('null-ls').builtins.formatting.prettierd,
    --require('null-ls').builtins.formatting.stylua,
    --require("null-ls").builtins.completion.spell,
    require("null-ls").builtins.formatting.eslint_d,
  },
  -- Format on save
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
    end
  end,
})
