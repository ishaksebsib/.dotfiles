----------------------------------------------
------- nvim reamps and tewaks ---------------
----------------------------------------------

-- set a leader
vim.g.mapleader = " "

-- Map 'jj' to act as Escape in insert mode
--vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Set cliipBoard system's clipboard
vim.cmd("set clipboard+=unnamedplus")

-- enable color support in terminal
vim.o.termguicolors = true

-- Enable line numbers and set them to relative
vim.o.number = true
vim.o.relativenumber = true

-- config tap
vim.cmd("set noexpandtab") -- Use actual tabs instead of spaces
vim.cmd("set tabstop=2") -- Number of spaces that a <Tab> in the file counts for
vim.cmd("set softtabstop=2") -- Number of spaces to use when editing
vim.cmd("set shiftwidth=2") -- Number of spaces used for autoindent

-- REMAPS

-- move half page and make it center
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz<CR>", { noremap = true, silent = true })

-- move to the right and left windows
vim.keymap.set("n", "gl", "<C-w>l", { desc = "Window: Move right" })
vim.keymap.set("n", "gh", "<C-w>h", { desc = "Window: Move left" })

-- copy relative file path
vim.keymap.set("n", "<leader>y", function()
	local relative_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	vim.fn.setreg("+", relative_path)
end, { noremap = true, silent = true })

-- copy absolute file path
vim.keymap.set("n", "<leader>Y", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { noremap = true, silent = true })
