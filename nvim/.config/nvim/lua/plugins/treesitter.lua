return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,

	-- set metta files as scheme
	vim.filetype.add({
		extension = {
			metta = "scheme",
		},
	}),

	-- use typescript tree sitter fro helix
	vim.filetype.add({
		extension = {
			hx = "hx",
		},
	}),

	-- register helix as typescript
	vim.treesitter.language.register("typescript", "hx"),
}
