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
	end,

	-- leader lc as leetcode leader key
	keys = {
		-- menu
		{ "<leader>lcm", "<cmd>Leet<cr>", desc = "leetcode" },
		-- run
		{ "<leader>lcr", "<cmd>Leet run<cr>", desc = "leetcode run" },
		-- submit
		{ "<leader>lcs", "<cmd>Leet submit<cr>", desc = "leetcode submit" },
		-- test
		{ "<leader>lct", "<cmd>Leet test<cr>", desc = "leetcode test" },
		-- console
		{ "<leader>lcc", "<cmd>Leet console<cr>", desc = "leetcode console" },
		-- info
		{ "<leader>lci", "<cmd>Leet info<cr>", desc = "leetcode info" },
		-- tabs
		{ "<leader>lct", "<cmd>Leet tabs<cr>", desc = "leetcode tabs" },
		-- lang
		{ "<leader>lcl", "<cmd>Leet lang<cr>", desc = "leetcode lang" },
		-- daily
		{ "<leader>lcd", "<cmd>Leet daily<cr>", desc = "leetcode daily" },
		-- list
		{ "<leader>lcl", "<cmd>Leet list<cr>", desc = "leetcode list" },
		-- exit
		{ "<leader>lce", "<cmd>Leet exit<cr>", desc = "leetcode exit" },

	},
}
