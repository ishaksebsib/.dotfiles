return {
	"gmr458/vscode_modern_theme.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("vscode_modern").setup({
			cursorline = false,
			transparent_background = false,
			nvim_tree_darker = true,
		})
	end,
}
