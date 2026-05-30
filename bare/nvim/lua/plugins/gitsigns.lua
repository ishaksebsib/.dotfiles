return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({})
	end,

	-- <leader>gi used as a prefix for all the gitsigns mappings

	-- preview hunk keymap
	vim.keymap.set(
		"n",
		"<leader>gih",
		"<cmd>lua require('gitsigns').preview_hunk()<CR>",
		{ noremap = true, silent = true, desc = "Preview hunk" }
	),

	-- stage hunk keymap
	vim.keymap.set(
		"n",
		"<leader>gis",
		"<cmd>lua require('gitsigns').stage_hunk()<CR>",
		{ noremap = true, silent = true, desc = "Stage hunk" }
	),

	-- undo stage hunk keymap
	vim.keymap.set(
		"n",
		"<leader>giu",
		"<cmd>lua require('gitsigns').undo_stage_hunk()<CR>",
		{ noremap = true, silent = true, desc = "Undo stage hunk" }
	),

	-- reset hunk keymap
	vim.keymap.set(
		"n",
		"<leader>gir",
		"<cmd>lua require('gitsigns').reset_hunk()<CR>",
		{ noremap = true, silent = true, desc = "Reset hunk" }
	),

	-- reset buffer keymap
	vim.keymap.set(
		"n",
		"<leader>giR",
		"<cmd>lua require('gitsigns').reset_buffer()<CR>",
		{ noremap = true, silent = true, desc = "Reset buffer" }
	),

	-- blame line keymap
	vim.keymap.set(
		"n",
		"<leader>gib",
		"<cmd>lua require('gitsigns').blame_line()<CR>",
		{ noremap = true, silent = true, desc = "Blame line" }
	),

	-- line diff keymap
	vim.keymap.set(
		"n",
		"<leader>gid",
		"<cmd>lua require('gitsigns').diffthis()<CR>",
		{ noremap = true, silent = true, desc = "Line diff" }
	),

	-- next hunk keymap
	vim.keymap.set(
		"n",
		"<leader>gin",
		"<cmd>lua require('gitsigns').next_hunk()<CR>",
		{ noremap = true, silent = true, desc = "Next hunk" }
	),

	-- prev hunk keymap
	vim.keymap.set(
		"n",
		"<leader>gip",
		"<cmd>lua require('gitsigns').prev_hunk()<CR>",
		{ noremap = true, silent = true, desc = "Prev hunk" }
	),
}
