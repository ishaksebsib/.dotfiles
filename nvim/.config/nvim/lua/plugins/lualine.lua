return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			-- make it on the top
			--
			options = {
				theme = "auto",

			},

			sections = {
				lualine_c = { { 'filename', path = 1 } }
			}

		})
	end,
}
