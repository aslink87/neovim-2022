return {
  "nvim-treesitter/nvim-treesitter",
  -- event = { "BufReadPost", "BufNewFile" },
  event = { "LazyFile", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
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
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)
    vim.schedule(function()
      require("lazy").load({ plugins = { "nvim-treesitter-textobjects" } })
    end)
  end,
}
