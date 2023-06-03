return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf",                                config = true },
      { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "simrat39/rust-tools.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        cssls = {},
        svelte = {},
        taplo = {},
        rust_analyzer = {
          mason = false,
          cmd = { vim.fn.expand("~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer") },
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              check = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end
        --   return true
        --- RUST CONFIG START ---
        -- rust_analyzer = function(_, opts)
        --   require("lazyvim.util").on_attach(function(client, buffer)
        --     -- stylua: ignore
        --     if client.name == "rust_analyzer" then
        --       vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", { buffer = buffer, desc = "Hover Actions (Rust)" })
        --       vim.keymap.set("n", "<leader>cu", "<cmd>RustCodeAction<cr>",
        --         { buffer = buffer, desc = "Code Action (Rust)" })
        --       vim.keymap.set("n", "<leader>dr", "<cmd>RustDebuggables<cr>",
        --         { buffer = buffer, desc = "Run Debuggables (Rust)" })
        --     end
        --   end)
        --   local rust_tools_opts = vim.tbl_deep_extend("force", opts, {
        --     dap = {
        --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        --     },
        --     tools = {
        --       on_initialized = function()
        --         vim.cmd([[
        --       augroup RustLSP
        --       autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
        --       autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
        --       autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
        --       augroup END
        --       ]])
        --       end,
        --     },
        --     server = {
        --       settings = {
        --         ["rust-analyzer"] = {
        --           cargo = {
        --             allFeatures = true,
        --             loadOutDirsFromCheck = true,
        --             runBuildScripts = true,
        --           },
        --           -- Add clippy lints for Rust.
        --           checkOnSave = {
        --             allFeatures = true,
        --             command = "clippy",
        --             extraArgs = { "--no-deps" },
        --           },
        --           procMacro = {
        --             enable = true,
        --             ignored = {
        --               ["async-trait"] = { "async_trait" },
        --               ["napi-derive"] = { "napi" },
        --               ["async-recursion"] = { "async_recursion" },
        --             },
        --           },
        --         },
        --       },
        --     },
        --   })
        --   require("rust-tools").setup(rust_tools_opts)
        --   return true
        -- end,
        -- taplo = function(_, _)
        --   local function show_documentation()
        --     if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
        --       require("crates").show_popup()
        --     else
        --       vim.lsp.buf.hover()
        --     end
        --   end
        --   require("lazyvim.util").on_attach(function(client, buffer)
        --     -- stylua: ignore
        --     if client.name == "taplo" then
        --       vim.keymap.set("n", "K", show_documentation, { buffer = buffer, desc = "Show Crate Documentation" })
        --     end
        --   end)
        --   return false -- make sure the base implementation calls taplo.setup
        -- end,
        --- RUST CONFIG END ---

        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local Util = require("lazyvim.util")
      -- setup autoformat
      require("lazyvim.plugins.lsp.format").setup(opts)
      -- setup formatting and keymaps
      Util.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- temp fix for lspconfig rename
      -- https://github.com/neovim/nvim-lspconfig/pull/2439
      local mappings = require("mason-lspconfig.mappings.server")
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = "lua-language-server"
        mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "jsonc",
              "yaml",
              "graphql",
              "handlebars",
              "svelte",
            },
          }),
          nls.builtins.formatting.rustywind,
          nls.builtins.formatting.prettierd,
          nls.builtins.diagnostics.eslint_d,
          -- nls.builtins.formatting.stylua,
          -- nls.builtins.diagnostics.flake8,
        },
        -- filetypes = {
        --   "svelte",
        -- },
      }
    end,
  },
}
