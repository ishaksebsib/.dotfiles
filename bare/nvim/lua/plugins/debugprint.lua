return {
	"Goose97/timber.nvim",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("timber").setup({
			-- Set to false to disable all default keymaps
			default_keymaps_enabled = false,
			keymaps = {
				-- Set to false to disable the default keymap for specific actions
				-- insert_log_below = false,
				insert_log_below = "gpj",
				insert_log_above = "gpk",
				insert_plain_log_below = "gpo",
				insert_plain_log_above = "gp<S-o>",
				insert_batch_log = "gpb",
				add_log_targets_to_batch = "gpa",
				insert_log_below_operator = "g<S-p>j",
				insert_log_above_operator = "g<S-p>k",
				insert_batch_log_operator = "g<S-p>b",
				add_log_targets_to_batch_operator = "g<S-p>a",
			},

			log_marker = "🪵 DEBUG LOG:", -- unique marker Timber will search for
			log_templates = {
				default = {
					javascript = [[console.log("%log_marker %log_target", %log_target)]],
					typescript = [[console.log("%log_marker %log_target", %log_target)]],
					astro = [[console.log("%log_marker %log_target", %log_target)]],
					vue = [[console.log("%log_marker %log_target", %log_target)]],
					jsx = [[console.log("%log_marker %log_target", %log_target)]],
					tsx = [[console.log("%log_marker %log_target", %log_target)]],
					lua = [[print("%log_marker %log_target", %log_target)]],
					luau = [[print("%log_marker %log_target", %log_target)]],
					ruby = [[puts("%log_marker %log_target #{%log_target}")]],
					elixir = [[IO.inspect(%log_target, label: "%log_marker %log_target")]],
					go = [[log.Printf("%log_marker %log_target: %v\n", %log_target)]],
					rust = [[println!("%log_marker %log_target: {:#?}", %log_target);]],
					python = [[print("%log_marker %log_target", %log_target)]],
					c = [[printf("%log_marker %log_target: %s\n", %log_target);]],
					cpp = [[std::cout << "%log_marker %log_target: " << %log_target << std::endl;]],
					java = [[System.out.println("%log_marker %log_target: " + %log_target);]],
					c_sharp = [[Console.WriteLine($"%log_marker %log_target: {%log_target}");]],
					odin = [[fmt.printfln("%log_marker %log_target: %v", %log_target)]],
					swift = [[print("%log_marker %log_target:", %log_target)]],
					kotlin = [[println("%log_marker %log_target: ${%log_target}")]],
					scala = [[println(s"%log_marker %log_target: ${%log_target}")]],
					dart = [[print("%log_marker %log_target: ${%log_target}");]],
				},
			},
		})
	end,

	-- remove all log markers
	vim.keymap.set("n", "gpc", function()
		require("timber.actions").clear_log_statements({ global = false })
	end, { desc = "Clear Timber log statements (buffer only)" }),

	-- search all logs
	vim.keymap.set("n", "gps", function()
		require("timber.actions").search_log_statements()
	end, { desc = "Search all logs" }),
}
