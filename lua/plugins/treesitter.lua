local pickers = require "telescope.pickers"
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- others builtin by default
        "css",
        "jsdoc",
        "scss",
        "svelte",
        "rust",
        "toml"
      },
      pickers = {
        find_files = {
          hidden = true
        },
      },
    },
  },
}
