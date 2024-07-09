local Miasma = {
  "xero/miasma.nvim",
  -- dev = true,
  -- branch = "dev",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme miasma")
  end,
}

local Tokyonight = {
  "folke/tokyonight.nvim",
  opts = {
    transparent = false,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
  lazy = false,
  config = function()
    vim.cmd("colorscheme tokyonight")
  end,
}

-- options include: wave, lotus, dragon
local Theme = "wave"

local Kanagawa = {
  "rebelot/kanagawa.nvim",
  lazy = false,
  config = function()
    vim.cmd("colorscheme kanagawa-" .. Theme)
  end,
}

return Kanagawa
