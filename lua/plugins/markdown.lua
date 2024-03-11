return {
  "iamcco/markdown-preview.nvim",
  event = "VeryLazy",
  cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
