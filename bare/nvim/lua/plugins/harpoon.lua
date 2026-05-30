return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			default = {
				BufLeave = function(arg, list)
					local bufnr = arg.buf
					local bufname = require("plenary.path"):new(vim.api.nvim_buf_get_name(bufnr)):make_relative(list.config.get_root_dir())
					local item = list:get_by_value(bufname)

					if item and item.context then
						local pos = vim.api.nvim_win_get_cursor(0)
						item.context.row = pos[1]
						item.context.col = pos[2]
						require("harpoon.extensions").extensions:emit(
							require("harpoon.extensions").event_names.POSITION_UPDATED,
							item
						)
					end
				end,
			},
		})

		-- Toggle Harpoon menu with leader + leader
		vim.keymap.set("n", "<leader><leader>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })

		-- Define the keys for marking (asdfghjkl)
		local mark_keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l" }

		for idx, key in ipairs(mark_keys) do
			vim.keymap.set("n", "m" .. key, function()
				local pos = vim.api.nvim_win_get_cursor(0)  -- Get current cursor position
				local item = { value = vim.fn.expand("%"), context = { row = pos[1], col = pos[2] } }  -- Include position in context
				harpoon:list():replace_at(idx, item)        -- Assign to the specific index
				print("Assigned current file to Harpoon position " .. idx .. " ('" .. key .. "')")
			end, { desc = "Assign file to Harpoon position " .. idx .. " ('" .. key .. "')" })

			vim.keymap.set("n", "'" .. key, function()
				local item = harpoon:list():get(idx)
				if item then
					harpoon:list():select(idx)
				else
					print("No mark at position " .. idx .. " ('" .. key .. "')")
				end
			end, { desc = "Go to Harpoon mark " .. idx .. " ('" .. key .. "')" })
		end

		-- Toggle previous & next buffers
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon previous" })

		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end, { desc = "Harpoon next" })

		-- Restore native Vim marks with leader prefix
		local alphabet = "abcdefghijklmnopqrstuvwxyz"
		for i = 1, #alphabet do
			local key = alphabet:sub(i, i)
			vim.keymap.set("n", "<leader>m" .. key, "m" .. key, { desc = "Set mark " .. key })
			vim.keymap.set("n", "<leader>'" .. key, "'" .. key, { desc = "Jump to mark " .. key })
		end
	end,
}
