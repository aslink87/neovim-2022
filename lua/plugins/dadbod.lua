return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    "pbogut/vim-dadbod-ssh",
  },
  init = function()
    local data_path = vim.fn.stdpath("config") .. require("plenary.path").path.sep

    vim.g.db_ui_save_location = data_path .. "db_ui"
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_show_database_icon = true
    vim.g.db_ui_tmp_query_location = data_path .. "db_ui/tmp"
    vim.g.db_ui_use_nerd_fonts = true
    vim.g.db_ui_use_nvim_notify = true
    vim.g.db_ui_execute_on_save = false
  end,
  keys = {
    { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle UI" },
    { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer" },
    { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Buffer" },
    { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
  },
}
