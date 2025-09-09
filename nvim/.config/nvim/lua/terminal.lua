local M = {}
M.term_bufs = {}  -- store buffers keyed by name

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
  vim.keymap.set({ "n", "t" }, key, function()
    M.toggle_terminal(name, cmd)
  end, { desc = "toggle " .. name })
end

-- mappings
M.map_terminal_key("tf", "fish", "fish")
M.map_terminal_key("tl", "lazygit", "lazygit")
M.map_terminal_key("tgd", "gh-dash", "gh dash")

return M
