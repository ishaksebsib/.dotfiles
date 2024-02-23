----------------------------------------------
------- nvim reamps and tewaks ---------------
----------------------------------------------

-- set a leader 
vim.g.mapleader = " "

-- Map 'jj' to act as Escape in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Set cliipBoard system's clipboard
vim.cmd('set clipboard+=unnamedplus')

-- config tap  
vim.cmd("set noexpandtab")     -- Use actual tabs instead of spaces
vim.cmd("set tabstop=4")       -- Number of spaces that a <Tab> in the file counts for
vim.cmd("set softtabstop=4")   -- Number of spaces to use when editing
vim.cmd("set shiftwidth=4")    -- Number of spaces used for autoindent

-- set theme
vim.cmd.colorscheme "catppuccin"


