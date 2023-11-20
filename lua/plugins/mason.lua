return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonInstallAll",
  config = function()
    local f = require("utils.functions")
    local mason_tool_installer = require("mason-tool-installer")
    require("mason").setup({
      ui = {
        border = "shadow",
        icons = require("utils.icons").mason,
        zindex = 99,
      },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "prettierd", -- prettierd formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "markdownlint", -- markdown linter
      },
    })
    f.cmd("MasonInstallAll", function()
      vim.cmd("MasonUpdate")
      local ensure_installed = {
        "bash-language-server",
        "black",
        "clang-format",
        "css-lsp",
        "dockerfile-language-server",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "php-cs-fixer",
        "prettierd",
        "python-lsp-server",
        "rust-analyzer",
        "shellcheck",
        "shellharden",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "terraform-ls",
        "tflint",
        "typescript-language-server",
        "yaml-language-server",
      }
      vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
    end, { desc = "install all lsp tools" })
  end,
}
