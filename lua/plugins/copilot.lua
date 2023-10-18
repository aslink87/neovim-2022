local M = {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    -- ft_disable = { "markdown", "terraform", "cpp" },
    suggestion = { enabled = true },
    panel = { enabled = true },
  },
  config = function()
    require("copilot").setup({})
  end,
}

return M
