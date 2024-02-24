local servers = {
	"clangd",
	"cssls",
	"dockerls",
	"gopls",
	"html",
	"jsonls",
	"tsserver",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"tailwindcss",
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities, -- here we attached lsp complition to cmp nvm lsp
				})
			end

			-- setup lsp for all language servers
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = {}
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		end,
	},
}
