-- auto close and rename tags
return {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({})
	end,
}
