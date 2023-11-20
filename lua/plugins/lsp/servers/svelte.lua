local util = require 'lspconfig.util'
-- local lspconfig = require("lspconfig")
--
-- lspconfig.svelte.setup {
--   filetypes = { "svelte" },
--   on_attach = function(client, bufnr)
--     if client.name == 'svelte' then
--       vim.api.nvim_create_autocmd("BufWritePost", {
--         pattern = { "*.js", "*.ts" },
--         callback = function(ctx)
--           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
--         end,
--       })
--     end
--   end
-- }

return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.document_formatting = true
		end,
		cmd = { "svelteserver", "--stdio" },
		filetypes = {
			"svelte",
		},
		init_options = {
			hostInfo = "neovim",
		},
		root_dir = util.root_pattern("svelte.config.js"),
		--root_dir = util.find_node_modules_ancestor,
		single_file_support = true,
	}
end
