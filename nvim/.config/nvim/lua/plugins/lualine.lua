--------------------------------------------------------------------
--  HELPER : show_global_marks()                                  --
--  Purpose : Collect all *global* uppercase marks (A-Z) that     --
--            exist in the current Neovim session and show them   --
--            in a Telescope picker.                              --
--            Needed because marks may live in unloaded buffers   --
--            after session-restore, so we force-load each buffer --
--            long enough to read its mark table, then unload it  --
--            again if it was not originally loaded.              --
--------------------------------------------------------------------
local function show_global_marks()
	local marks = {}

	-- Helper: expand a mark record into Telescope items
	local function add_mark(bufnr, mark)
		local pos = vim.api.nvim_buf_get_mark(bufnr, mark)
		if pos[1] == 0 then return end -- mark does not exist
		local file = vim.api.nvim_buf_get_name(bufnr)
		table.insert(marks, {
			mark    = mark,
			file    = vim.fn.fnamemodify(file, ':~:.'),
			lnum    = pos[1],
			col     = pos[2],
			display = string.format('%-2s  %s:%d:%d', mark,
				vim.fn.fnamemodify(file, ':t'), pos[1], pos[2])
		})
	end

	-- Scan every buffer that is **mentioned** in the session (listed or not)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local was_loaded = vim.api.nvim_buf_is_loaded(buf)
		if not was_loaded then
			vim.fn.bufload(buf) -- load it into RAM
		end

		-- Now we can read the global marks stored in that buffer
		for c = 65, 90 do -- A-Z
			add_mark(buf, string.char(c))
		end

		-- Unload again if it wasn’t loaded before
		if not was_loaded and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { unload = true })
		end
	end

	if #marks == 0 then
		vim.notify('No global marks found', vim.log.levels.WARN)
		return
	end

	require('telescope.pickers').new({}, {
		prompt_title = 'Global Marks',
		finder = require('telescope.finders').new_table {
			results = marks,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.display,
					ordinal = entry.display,
					filename = entry.file,
					lnum = entry.lnum,
					col = entry.col,
				}
			end,
		},
		sorter = require('telescope.config').values.generic_sorter({}),
		attach_mappings = function(_, map)
			map('i', '<CR>', function(buf)
				local selection = require('telescope.actions.state').get_selected_entry()
				require('telescope.actions').close(buf)
				vim.cmd('normal! `' .. selection.value.mark)
			end)
			return true
		end,
	}):find()
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			-- make it on the top
			--
			options = {
				theme = "auto",

			},

			sections = {
				lualine_c = {
					{ 'filename', path = 1 }
					--{
					--"buffers",
					--show_filename_only = false,
					--mode = 2,
					--}
				}
			}

		})
	end,

	-- Cycle and delete buffers
	vim.keymap.set("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer" }),
	vim.keymap.set("n", "<leader>p", ":bprevious<CR>", { desc = "Previous buffer" }),
	vim.keymap.set("n", "<leader>w", ":bdelete<CR>", { desc = "Delete buffer" }),


	-- Set:  <leader>ma  … <leader>mz  (lowercase key becomes uppercase mark)
	vim.keymap.set('n', '<leader>m', function()
		local key = vim.fn.getcharstr():upper()
		vim.cmd('normal! m' .. key)
		vim.notify('Mark ' .. key .. ' set')
	end),

	-- Goto: <leader>'a … <leader>'z
	vim.keymap.set('n', "<leader>'", function()
		local key = vim.fn.getcharstr():upper()
		vim.cmd('normal! `' .. key)
	end),

	-- Show all global marks in a floating window
	vim.keymap.set('n', "<leader>M", show_global_marks, { desc = "Show global marks" }),

	-- Cycle buffers by index
	--vim.keymap.set("n", "<leader>1", "<Cmd>LualineBuffersJump 1<CR>", { desc = "Go to Buffer 1" }),
	--vim.keymap.set("n", "<leader>2", "<Cmd>LualineBuffersJump 2<CR>", { desc = "Go to Buffer 2" }),
	--vim.keymap.set("n", "<leader>3", "<Cmd>LualineBuffersJump 3<CR>", { desc = "Go to Buffer 3" }),
	--vim.keymap.set("n", "<leader>4", "<Cmd>LualineBuffersJump 4<CR>", { desc = "Go to Buffer 4" }),
	--vim.keymap.set("n", "<leader>5", "<Cmd>LualineBuffersJump 5<CR>", { desc = "Go to Buffer 5" }),
	--vim.keymap.set("n", "<leader>6", "<Cmd>LualineBuffersJump 6<CR>", { desc = "Go to Buffer 6" }),
	--vim.keymap.set("n", "<leader>7", "<Cmd>LualineBuffersJump 7<CR>", { desc = "Go to Buffer 7" }),
	--vim.keymap.set("n", "<leader>8", "<Cmd>LualineBuffersJump 8<CR>", { desc = "Go to Buffer 8" }),
	--vim.keymap.set("n", "<leader>9", "<Cmd>LualineBuffersJump 9<CR>", { desc = "Go to Buffer 9" }),
}
