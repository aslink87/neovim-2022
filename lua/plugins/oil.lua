return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Explorer Oil (parent dir)" },
  },
  config = function()
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select.split",
      },
      view_options = {
        show_hidden = true,
      },
    })
  end,
}
