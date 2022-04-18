local query = require('nvim-treesitter.query')

local foldmethod_backups = {}
local foldexpr_backups = {}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  autotag = {
    enable = true
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss",
    "javascript"
  },
}

require'nvim-treesitter.configs'.define_modules {
  folding = {
    enabled = true,
      attach = function(bufnr)
      -- Fold settings are actually window based...
      foldmethod_backups[bufnr] = vim.wo.foldmethod
      foldexpr_backups[bufnr] = vim.wo.foldexpr
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
    detach = function(bufnr)
      vim.wo.foldmethod = foldmethod_backups[bufnr]
      vim.wo.foldexpr = foldexpr_backups[bufnr]
      foldmethod_backups[bufnr] = nil
      foldexpr_backups[bufnr] = nil
    end,
    is_supported = query.has_folds
  }
}
--vim.opt.foldmethod=expr
--vim.opt.foldexpr=nvim_treesitter#foldexpr()

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
