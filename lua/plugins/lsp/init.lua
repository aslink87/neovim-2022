return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- "folke/neodev.nvim",
    "b0o/schemastore.nvim",
    "williamboman/mason-lspconfig.nvim",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      cssls = { settings = { css = { lint = { unknownAtRules = "ignore" } } } },
      tailwindcss = { settings = { css = { lint = { unknownAtRules = "ignore" } } } },
    },
  },
}
