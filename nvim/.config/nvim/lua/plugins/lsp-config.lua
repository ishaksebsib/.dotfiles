function YankDiagnosticError()
	vim.diagnostic.open_float()
	vim.diagnostic.open_float()
	local win_id = vim.fn.win_getid()   -- get the window ID of the floating window
	vim.cmd("normal! j")                -- move down one row
	vim.cmd("normal! VG")               -- select everything from that row down
	vim.cmd("normal! y")                -- yank selected text
	vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end

local servers = {
	clangd = {},
	cssls = {},
	dockerls = {},
	gopls = {},
	html = {},
	jsonls = {},
	ts_ls = {},
	pyright = {},
	rust_analyzer = {},
	tailwindcss = {},
	--eslint = {},
	biome = {},
	svelte = {},
	elmls = {},
	lua_ls = { Lua = { diagnostics = { globals = { "vim" } } } },
}

return {
	{
		"mason-org/mason.nvim",
		opts = {}
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

			-- Set up lsp for all servers with capabilities and configurations
			for server, cfg in pairs(servers) do
				cfg.capabilities = capabilities
				lspconfig[server].setup(cfg)
			end

			-- setup lsp for all language servers
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = {}
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts)

			-- leader g fammily maps

			vim.keymap.set({ "n", "v" }, "<leader>gca", vim.lsp.buf.code_action,
				{ noremap = true, desc = "Code Actions" })

			vim.keymap.set({ "n", "v" }, "<leader>gn", vim.lsp.buf.rename,
				{ noremap = true, desc = "Rename All Same Variables" })

			vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float,
				{ noremap = true, silent = true, desc = "Show current Error in float" })

			vim.keymap.set('n', '<leader>gE', [[:lua YankDiagnosticError()<CR>]],
				{ noremap = true, silent = true, desc = "Copy error" })
		end,
	},
}
