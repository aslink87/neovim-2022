return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    ---@diagnostic disable-next-line
    treesitter.setup({
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "go",
        "graphql",
        "hcl",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "regex",
        "regex",
        "ruby",
        "rust",
        "scss",
        "sql",
        "svelte",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true,
      },
      match = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "zi",
          node_incremental = "zi",
          scope_incremental = "zo",
          node_decremental = "zd",
        },
      },
      indent = {
        enable = true,
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })
  end,
  build = function()
    vim.cmd([[TSUpdate]])
  end,
}
