return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		harpoon.setup({})
	end,

	keys = {
		{ "<leader><leader>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "open harpoon menu" },

		--- leader m on normal mode to add a mark
		{ "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "add harpoon mark" },
		-- leader M to unmark
		{ "<leader>M", "<cmd>lua require('harpoon.mark').rm_file()<cr>", desc = "clear harpoon mark" },

		-- cycle between marks
		{ "<leader>n", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "harpoon nav next" },
		{ "<leader>p", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "harpoon nav prev" },

		-- Navigation between marks
		{ "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "harpoon nav 1" },
		{ "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "harpoon nav 2" },
		{ "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "harpoon nav 3" },
		{ "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "harpoon nav 4" },
		{ "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "harpoon nav 5" },
		{ "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "harpoon nav 6" },
		{ "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", desc = "harpoon nav 7" },
		{ "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", desc = "harpoon nav 8" },
		{ "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", desc = "harpoon nav 9" },
		{ "<leader>0", "<cmd>lua require('harpoon.ui').nav_file(10)<cr>", desc = "harpoon nav 10" },

	}
}
