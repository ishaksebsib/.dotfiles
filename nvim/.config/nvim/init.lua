----------------------------------------------
-------  setup lazy package manager ----------
----------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load setups
require("vim-options")
require("lazy").setup("plugins")

-- set theme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd.colorscheme("gruvbox")
--vim.cmd.colorscheme("darkplus")

-- enable diagnostic signs
vim.diagnostic.config({
	virtual_text = {
		source = "if_many", -- Only show source if there are multiple diagnostics
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
})
