return {
	"developedbyed/marko.nvim",
	config = function()
		require("marko").setup({
			width = 100,
			height = 100,
			border = "rounded",
			title = " Marks ",

			-- Navigation mode: "popup" (default) or "direct" (jump directly to marks)
			navigation_mode = "popup",

			-- Default keymap to open popup (set to false to disable)
			default_keymap = false,

			-- Virtual text configuration
			virtual_text = {
				enabled = false,
			},
		})
	end,

	vim.keymap.set("n", "<leader><leader>", function()
		require("marko").toggle_marks()
	end, { desc = "Show marks popup" }),

	-- REVERSE the default go to marks
	--
	-- Goto global mark ' + a-z
	vim.keymap.set("n", "'", function()
		vim.cmd("normal! `" .. vim.fn.getcharstr():upper())
	end, { desc = "Goto global mark <a-z>" }),

	-- Goto local mark leader + ' + a-z
	vim.keymap.set("n", "<leader>'", function()
		vim.cmd("normal! `" .. vim.fn.getcharstr())
	end, { desc = "Goto local mark <a-z>" }),

	-- REVERSE the defualt set marks
	--
	-- Set global mark m + a-z
	vim.keymap.set("n", "m", function()
		vim.cmd("mark " .. vim.fn.getcharstr():upper())
	end, { desc = "Set global mark <a-z>" }),

	-- Set local mark leader + m + a-z
	vim.keymap.set("n", "<leader>m", function()
		vim.cmd("mark " .. vim.fn.getcharstr())
	end, { desc = "Set local mark <a-z>" }),
}
