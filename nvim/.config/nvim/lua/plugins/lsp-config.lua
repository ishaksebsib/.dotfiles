function YankDiagnosticError()
	vim.diagnostic.open_float()
	vim.diagnostic.open_float()
	local win_id = vim.fn.win_getid() -- get the window ID of the floating window
	vim.cmd("normal! j") -- move down one row
	vim.cmd("normal! VG") -- select everything from that row down
	vim.cmd("normal! y") -- yank selected text
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
	tailwindcss = {},
	--eslint = {},
	--svelte = {},
	--elmls = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				cargo = {
					allFeatures = true,
				},
				procMacro = {
					enable = true,
				},
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				format = {
					enable = false,
				},
			},
		},
	},
}

local formatters = {
	biome = {},
	stylua = {},
	black = {},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants

			-- For lsp and formatting notifications
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0, -- Background color opacity in the notification window
						},
					},
				},
			},
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			--  Ensure the servers installed
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, vim.tbl_keys(formatters or {}))
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- cmp_nvim lsp capabilities plus vim protocol capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Set up lsp for all servers with capabilities and configurations
			for server, cfg in pairs(servers) do
				cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
				vim.lsp.config(server, cfg)
				vim.lsp.enable(server)
			end

			local builtin = require("telescope.builtin")

			-- setup lsp for all language servers
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			--vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, { desc = "Type definition" })
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: Git Status" })

			vim.keymap.set(
				"n",
				"<leader>d",
				builtin.diagnostics,
				{ noremap = true, silent = true, desc = "Open diagnostics in telescope" }
			)

			vim.keymap.set(
				{ "n", "v" },
				"<leader>a",
				vim.lsp.buf.code_action,
				{ noremap = true, desc = "Code Actions" }
			)

			vim.keymap.set(
				{ "n", "v" },
				"<leader>r",
				vim.lsp.buf.rename,
				{ noremap = true, desc = "Rename All Same Variables" }
			)

			vim.keymap.set(
				"n",
				"<leader>gd",
				vim.diagnostic.open_float,
				{ noremap = true, silent = true, desc = "Show current Error in float" }
			)

			vim.keymap.set(
				"n",
				"yd",
				[[:lua YankDiagnosticError()<CR>]],
				{ noremap = true, silent = true, desc = "Copy error" }
			)
		end,
	},
}
