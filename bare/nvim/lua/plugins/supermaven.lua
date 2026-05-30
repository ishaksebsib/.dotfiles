return {
	'supermaven-inc/supermaven-nvim',

	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				accept_word = "<S-Tab>",
				clear_suggestion = "<C-]>",
			},
			--ignore_filetypes = { cpp = true }, -- or { "cpp", }
			condition = function()
				return false
			end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
		})
	end,

}
