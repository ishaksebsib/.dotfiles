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

-- setup lazy package manager 
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

-- plugin and options for lazypackage manager
local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "typescript", 
          "html",
          "go",
          "python",
          "rust",
          "css"
        },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
    },
}
local opts = {}


-- load setups
require("lazy").setup(plugins, opts)
require("catppuccin").setup()

-- set theme
vim.cmd.colorscheme "catppuccin"

-- config lelescope
local builtin = require('telescope.builtin') -- save all telescpoe builting funcitonalitys to var
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})



