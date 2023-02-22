return {
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          init = function()
            require("lspconfig.server_configurations.eslint").on_attach(function(_, buffer)
              vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                  vim.lsp.buf.format({ async = true })
                end,
                group = vim.api.nvim_create_augroup("format_on_save", { clear = false }),
              })
            end)
            require("lspconfig.server_configurations.eslint").settings = {
              codeAction = {
                disableRuleComment = {
                  enable = true,
                  location = "separateLine",
                },
                showDocumentation = {
                  enable = true,
                },
              },
              codeActionOnSave = {
                enable = false,
                mode = "all",
              },
              format = true,
              nodePath = "",
              onIgnoredFiles = "off",
              packageManager = "npm",
              quiet = false,
              rulesCustomizations = {},
              run = "onType",
              useESLintClass = false,
              validate = "on",
              workingDirectory = {
                mode = "location",
              },
            }
            require("lspconfig.server_configurations.eslint").enable_format_on_save()
          end,
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    },
  },
}
