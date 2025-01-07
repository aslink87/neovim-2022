return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  priority = 100,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "windwp/nvim-autopairs",
    "onsails/lspkind-nvim",
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      enabled = true,
      preselect = cmp.PreselectMode.None,
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
        }),
      },
      ---@diagnostic disable-next-line
      view = {
        entries = "bordered",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping(function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      },
      sources = {
        { name = "nvim_lsp_signature_help", group_index = 1 },
        { name = "luasnip", max_item_count = 5, group_index = 1 },
        { name = "nvim_lsp", max_item_count = 20, group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "copilot", group_index = 1, keyword_length = 3 },
        { name = "vim-dadbod-completion", group_index = 1 },
        { name = "path", group_index = 2 },
        { name = "buffer", keyword_length = 2, max_item_count = 3, group_index = 2 },
      },
    })
  end,
}
