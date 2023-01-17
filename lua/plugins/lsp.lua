return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        tailwindcss = {},
        cssls = {},
        svelte = {},
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
    },
    lazy = true,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less",
              "html", "json", "jsonc", "yaml", "graphql", "handlebars", "svelte" }
          }),
          nls.builtins.formatting.rustywind,
          -- nls.builtins.formatting.prettier,
          nls.builtins.diagnostics.eslint,
          -- nls.builtins.formatting.stylua,
          -- nls.builtins.diagnostics.flake8,
        },
        filetypes = {
          "svelte"
        }
      }
    end,
  },
}
