return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",   -- disable nvim-treesitter
	dependencies = {
		"nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("leetcode").setup({
			lang = "rust",
		})
	end
}
