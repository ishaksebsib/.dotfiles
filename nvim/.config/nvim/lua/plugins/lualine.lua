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
				lualine_c = {
					{
						"buffers",
						show_filename_only = false,
						mode = 2,
					}
				}
			}

		})
	end,

	-- Cycle and delete buffers
	vim.keymap.set("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer" }),
	vim.keymap.set("n", "<leader>p", ":bprevious<CR>", { desc = "Previous buffer" }),
	vim.keymap.set("n", "<leader>w", ":bdelete<CR>", { desc = "Delete buffer" }),

	-- Cycle buffers by index
	vim.keymap.set("n", "<leader>1", ":LualineBuffersJump 1<CR>", { desc = "Go to Buffer 1" }),
	vim.keymap.set("n", "<leader>2", ":LualineBuffersJump 2<CR>", { desc = "Go to Buffer 2" }),
	vim.keymap.set("n", "<leader>3", ":LualineBuffersJump 3<CR>", { desc = "Go to Buffer 3" }),
	vim.keymap.set("n", "<leader>4", ":LualineBuffersJump 4<CR>", { desc = "Go to Buffer 4" }),
	vim.keymap.set("n", "<leader>5", ":LualineBuffersJump 5<CR>", { desc = "Go to Buffer 5" }),
	vim.keymap.set("n", "<leader>6", ":LualineBuffersJump 6<CR>", { desc = "Go to Buffer 6" }),
	vim.keymap.set("n", "<leader>7", ":LualineBuffersJump 7<CR>", { desc = "Go to Buffer 7" }),
	vim.keymap.set("n", "<leader>8", ":LualineBuffersJump 8<CR>", { desc = "Go to Buffer 8" }),
	vim.keymap.set("n", "<leader>9", ":LualineBuffersJump 9<CR>", { desc = "Go to Buffer 9" }),
}
