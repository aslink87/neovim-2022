return {
  { "nvim-lualine/lualine.nvim",
    opts = function(plugin)
      local icons = require("lazyvim.config").icons
      return {
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, shorting_target = 40, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          }
        }
      }
    end,
  }
}
