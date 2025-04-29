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

	"clangd",
	"cssls",
	"dockerls",
	"gopls",
	"html",
	"jsonls",
	"ts_ls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"tailwindcss",
	"eslint",
	"svelte",
	"elmls",
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

			local function on_attach(client, bufnr)
				-- Track inlay hint visibility per buffer using a buffer variable
				vim.b[bufnr].inlay_hints_visible = vim.b[bufnr].inlay_hints_visible or false

				local function toggle_inlay_hints()
					if not client.server_capabilities.inlayHintProvider then
						vim.notify("Inlay hints are not supported by this server.", vim.log.levels.WARN)
						return
					end

					vim.b[bufnr].inlay_hints_visible = not vim.b[bufnr].inlay_hints_visible
					vim.lsp.inlay_hint.enable(vim.b[bufnr].inlay_hints_visible, { bufnr })

					local status = vim.b[bufnr].inlay_hints_visible and "enabled" or "disabled"
					vim.notify("Inlay hints " .. status)
				end

				-- Set keymap for toggling inlay hints
				vim.keymap.set("n", "<leader>i", toggle_inlay_hints, { buffer = bufnr, desc = "Toggle Inlay Hints" })
			end

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					on_attach = on_attach,
					capabilities = capabilities, -- here we attached lsp complition to cmp nvm lsp
				})
			end

			-- Fix "undefined global 'vim'" for Lua
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					hint = {
						enable = true,
					},
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Define 'vim' as a recognized global
						},
					},
				},
			})

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
