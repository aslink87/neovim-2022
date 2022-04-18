vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require'cmp'
local lspkind = require('lspkind')
local luasnip = require("luasnip")
local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp', keyword_length = 4 },
    { name = 'vsnip', keyword_length = 2 }, -- For vsnip users.
    { name = 'luasnip', keyword_length = 2 }, -- For luasnip users. -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'path' },
    { name = 'buffer', keyword_length = 4 },
  },
  formatting = {
    format = lspkind.cmp_format {
      --mode = 'text',
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        --gh_issues = "[issues]",
        --tn = "[TabNine]",
      },
    },
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- html snippets in javascript and javascriptreact
luasnip.snippets = {
  html = {}
}
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
luasnip.snippets.typescriptreact = luasnip.snippets.html

require('luasnip').filetype_extend("javascript", { "javascriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })
require("luasnip/loaders/from_vscode").load({include = {"html"}})
require("luasnip/loaders/from_vscode").lazy_load()

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}
require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}
require('lspconfig')['rust_analyzer'].setup {
  capabilities = capabilities
}
require('lspconfig')['html'].setup {
  capabilities = capabilities
}
require('lspconfig')['cssls'].setup {
  capabilities = capabilities
}
require('lspconfig')['jsonls'].setup {
  capabilities = capabilities
}


--local cmp = require "cmp"
--local luasnip = require("luasnip")
--local lspkind = require('lspkind')
--cmp.setup {
    --snippet = {
      ---- REQUIRED - you must specify a snippet engine
      --expand = function(args)
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        --require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        ---- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        ---- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      --end,
    --},
    --mapping = {
      --['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      --['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      --['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      --['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      --['<C-e>'] = cmp.mapping({
        --i = cmp.mapping.abort(),
        --c = cmp.mapping.close(),
      --}),
      ---- Accept currently selected item. If none selected, `select` first item.
      ---- Set `select` to `false` to only confirm explicitly selected items.
      --['<CR>'] = cmp.mapping.confirm({ 
        --select = true,
        --behavior = cmp.ConfirmBehavior.Replace
      --}),
      --["<Tab>"] = cmp.mapping(function(fallback)
      --if cmp.visible() then
        --cmp.select_next_item()
        --elseif luasnip.expand_or_jumpable() then
          --luasnip.expand_or_jump()
        --elseif has_words_before() then
          --cmp.complete()
        --else
          --fallback()
        --end
      --end, { "i", "s" }),
      --["<S-Tab>"] = cmp.mapping(function(fallback)
        --if cmp.visible() then
          --cmp.select_prev_item()
        --elseif luasnip.jumpable(-1) then
          --luasnip.jump(-1)
        --else
          --fallback()
        --end
      --end, { "i", "s" }),

    --},
    --sources = {
      --{ name = 'nvim_lsp', keyword_length = 4 },
      --{ name = 'vsnip', keyword_length = 2 }, -- For vsnip users.
      --{ name = 'luasnip', keyword_length = 2 }, -- For luasnip users. -- { name = 'ultisnips' }, -- For ultisnips users.
      ---- { name = 'snippy' }, -- For snippy users.
      --{ name = 'path' },
      --{ name = 'buffer', keyword_length = 4 },
    --},
    --formatting = {
      --format = lspkind.cmp_format {
        ----mode = 'text',
        --with_text = true,
        --menu = {
          --buffer = "[buf]",
          --nvim_lsp = "[LSP]",
          --nvim_lua = "[api]",
          --path = "[path]",
          --luasnip = "[snip]",
          ----gh_issues = "[issues]",
          ----tn = "[TabNine]",
        --},
      --},
    --},
  --}

--local luasnip = require("luasnip")

---- html snippets in javascript and javascriptreact
--luasnip.snippets = {
  --html = {}
--}
--luasnip.snippets.javascript = luasnip.snippets.html
--luasnip.snippets.javascriptreact = luasnip.snippets.html
--luasnip.snippets.typescriptreact = luasnip.snippets.html

--require('luasnip').filetype_extend("javascript", { "javascriptreact" })
--require('luasnip').filetype_extend("javascript", { "html" })
--require("luasnip/loaders/from_vscode").load({include = {"html"}})
--require("luasnip/loaders/from_vscode").lazy_load()
