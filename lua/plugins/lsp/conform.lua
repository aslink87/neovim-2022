return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 500,
        })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    format = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
    },
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      svelte = { "svelte_fmt" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      svelte_fmt = {
        command = "prettier",
        args = { "--plugin", "prettier-plugin-svelte", "$FILENAME" },
      },
    },
  },
}
