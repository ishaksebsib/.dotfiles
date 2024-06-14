return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.biome,
				null_ls.builtins.formatting.isort, -- formatter for python
				null_ls.builtins.formatting.black, -- formater for python
				-- null_ls.builtins.diagnostics.eslint-lsp,
			},
			-- uncomment if you want auto format when save

			--[[on_attach = function(client, bufnr)]]
			--[[if client.supports_method("textDocument/formatting") then]]
			--[[vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })]]
			--[[vim.api.nvim_create_autocmd("BufWritePre", {]]
			--[[group = augroup,]]
			--[[buffer = bufnr,]]
			--[[callback = function()]]
			--[[-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead]]
			--[[-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead]]
			--[[-- vim.lsp.buf.formatting_sync() check ducumentation for more info]]

			--[[vim.lsp.buf.format({ async = false })]]
			--[[end,]]
			--[[})]]
			--[[end]]
			--[[end,]]
		})

		vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, {})
	end,
}
