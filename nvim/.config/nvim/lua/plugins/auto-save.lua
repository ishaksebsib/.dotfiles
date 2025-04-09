return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({})

		-- auto format on save
		--vim.api.nvim_create_autocmd("BufWritePre", {
		--pattern = "*",
		--callback = function()
		--vim.lsp.buf.format({ async = false })
		--end,
		--})
	end,
}
