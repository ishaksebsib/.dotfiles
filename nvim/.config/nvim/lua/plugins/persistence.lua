return {
	"folke/persistence.nvim",
	event = "BufReadPre",                          -- this will only start session saving when an actual file was opened
	opts = {
		dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
		-- minimum number of file buffers that need to be open to save
		-- Set to 0 to always save
		need = 1,
		branch = true, -- use git branch to save session
	},

	-- load the session for the current directory
	vim.keymap.set("n", "<leader>ls", function() require("persistence").load() end, { desc = "Load session" }),

	-- select a session to load
	vim.keymap.set("n", "<leader>lS", function() require("persistence").select() end, { desc = "Select session" }),

	-- load the last session
	vim.keymap.set("n", "<leader>ll", function() require("persistence").load({ last = true }) end, { desc = "Load last session" }),

	-- stop Persistence => session won't be saved on exit
	vim.keymap.set("n", "<leader>ld", function() require("persistence").stop() end, { desc = "Stop Persistence" }),
}
