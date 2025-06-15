return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	--behaviour = {
		--enable_cursor_planning_mode = true, -- enable cursor planning mode! good for small models
	--},
	opts = {
		provider = "openai",
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				extra_request_body = {
					--timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
					temperature = 0.75,
					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
					--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
				},
			},
		},
	},

	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { "Avante" }, --file_types = { "markdown", "Avante" },
			},
			ft = { "Avante" },       --ft = { "markdown", "Avante" },
		},
	},

	keys = {
		{ "<leader>ak", "<cmd>AvanteClear<cr>", desc = "Avante: Clear the current session" },
	},
}
