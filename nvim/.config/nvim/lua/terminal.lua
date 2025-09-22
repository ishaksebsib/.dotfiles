local M = {}
M.term_bufs = {} -- store buffers keyed by name

-- Toggle a terminal buffer for a given command and name
function M.toggle_terminal(name, cmd)
	if M.term_bufs[name] and vim.api.nvim_buf_is_valid(M.term_bufs[name]) then
		vim.api.nvim_buf_delete(M.term_bufs[name], { force = true })
		M.term_bufs[name] = nil
		return
	end

	vim.cmd("enew") -- new buffer
	local buf = vim.api.nvim_get_current_buf()
	M.term_bufs[name] = buf

	vim.fn.termopen(cmd, {
		on_exit = function()
			M.term_bufs[name] = nil
		end,
	})
	vim.cmd("startinsert")
end

-- function to map a key to a command
function M.map_terminal_key(key, name, cmd)
	vim.keymap.set("n", key, function()
		M.toggle_terminal(name, cmd)
	end, { desc = "open " .. name .. " on terminal" })
end

-- mappings
M.map_terminal_key("<leader>tf", "fish", "fish")
M.map_terminal_key("<leader>tl", "lazygit", "lazygit")
M.map_terminal_key("<leader>tg", "gh-dash", "gh dash")

-- universal close mapping for all terminal buffers
vim.keymap.set("t", "<C-w>", function()
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_delete(buf, { force = true })
end, { desc = "close terminal" })

return M
