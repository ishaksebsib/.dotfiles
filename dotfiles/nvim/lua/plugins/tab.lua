return {
	"akinsho/bufferline.nvim",
	requires = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				-- show_tab_indicators = false,
				separator_style = { "", "" }, -- | "slope" | "slant"| "thin" | "thick" | { 'any', 'any' },
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "left",
						separator = false,
					},
				},
			},
		})
		-- RE MPAS
		vim.opt.termguicolors = true

		vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>w", ":BufferLinePickClose<CR>", { noremap = true, silent = true })
	end,
}
