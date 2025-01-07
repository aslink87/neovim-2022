return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "none",
      ["<CR>"] = { "select_and_accept" },
      ["<C-k>"] = { "select_prev" },
      ["<C-j>"] = { "select_next" },
      ["<C-d>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
      ["<C-e>"] = { "cancel" },
    },
  },
}
