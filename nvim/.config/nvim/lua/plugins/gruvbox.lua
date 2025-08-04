return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			contrast = "hard", -- can be "hard", "soft" or empty string
			overrides = {
				NormalFloat = { bg = "#1d2021" },
				SignColumn = { bg = "#1d2021" },
			},
		},
	},
}
