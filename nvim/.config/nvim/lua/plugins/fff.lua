	return {
		"dmtrKovalenko/fff.nvim",
		build = "cargo build --release",
		lazy = false,
		-- or if you are using nixos
		-- build = "nix run .#release",
		opts = {
			-- pass here all the options
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("fff_telescope_wrapper").find_files()
				end,
				desc = "Open file picker",
			},
		},
	}
