require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- my coustom config

-- Remap jj to act as <Esc> in insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })

-- Remap jj to act as <Esc> in command-line mode
vim.api.nvim_set_keymap('c', 'jj', '<C-c>', { noremap = true })

-- Copy selected text to system clipboard in visual mode
vim.api.nvim_set_keymap('x', '<C-c>', '"+y', { noremap = true, silent = true })

-- Remap 'p' to paste from the system clipboard in normal mode
vim.api.nvim_set_keymap('n', 'p', '"+p', { noremap = true, silent = true })


-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"
