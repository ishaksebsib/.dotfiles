return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
			},

			sections = {
				lualine_c = {
					{ "filename", path = 1 },
					--{
					--"buffers",
					--show_filename_only = false,
					--mode = 2,
					--}
				},
			},
		})
	end,

	-- Cycle and delete buffers
	vim.keymap.set("n", "L", "<CMD>bnext<CR>", { desc = "Next buffer" }),
	vim.keymap.set("n", "H", "<CMD>bprevious<CR>", { desc = "Previous buffer" }),
	vim.keymap.set("n", "<leader>w", "<CMD>bdelete<CR>", { desc = "Delete buffer" }),
}
