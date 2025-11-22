local function show_global_marks()
	local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
	local global_marks = {}
	for i = 65, 90 do
		local mark = string.char(i)
		local pos = vim.fn.getpos("'" .. mark)
		if pos[1] ~= 0 then
			local file = vim.fn.bufname(pos[1])
			local rel_file = git_root ~= "" and file:find(git_root, 1, true) == 1 and file:sub(#git_root + 2)
				or vim.fn.fnamemodify(file, ":.")
			table.insert(global_marks, { mark = mark, file = file, rel_file = rel_file, pos = pos })
		end
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Global Marks",
			finder = require("telescope.finders").new_table({
				results = global_marks,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.mark .. " " .. entry.rel_file .. ":" .. entry.pos[2],
						ordinal = entry.mark .. ' ' .. entry.rel_file,
						filename = entry.file,
						lnum = entry.pos[2],
						col = entry.pos[3],
					}
				end,
			}),
			sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry()
					vim.cmd("normal! `" .. selection.value.mark)
				end)
				return true
			end,
		})
		:find()
end

return {
	"mohseenrm/marko.nvim",
	config = function()
		require("marko").setup()
	end,

	-- Show global marks
	vim.keymap.set("n", "<leader><leader>", show_global_marks, { desc = "Show global marks" }),

	-- REVERSE the default go to marks
	--
	-- Goto global mark ' + a-z
	vim.keymap.set("n", "'", function()
		vim.cmd("normal! `" .. vim.fn.getcharstr():upper())
	end, { desc = "Goto global mark <a-z>" }),

	-- Goto local mark leader + ' + a-z
	vim.keymap.set("n", "<leader>'", function()
		vim.cmd("normal! `" .. vim.fn.getcharstr())
	end, { desc = "Goto local mark <a-z>" }),

	-- REVERSE the defualt set marks
	--
	-- Set global mark m + a-z
	vim.keymap.set("n", "m", function()
		vim.cmd("mark " .. vim.fn.getcharstr():upper())
	end, { desc = "Set global mark <a-z>" }),

	-- Set local mark leader + m + a-z
	vim.keymap.set("n", "<leader>m", function()
		vim.cmd("mark " .. vim.fn.getcharstr())
	end, { desc = "Set local mark <a-z>" }),
}
