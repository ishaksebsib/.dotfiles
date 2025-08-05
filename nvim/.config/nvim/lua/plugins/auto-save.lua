return {
	"okuuva/auto-save.nvim",
	version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
	cmd = "ASToggle", -- optional for lazy loading on command
	event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
	opts = {
		enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
		trigger_events = { -- See :h events
			immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- vim events that trigger an immediate save

			-- NOTE: set this empty for harpoon menu to work
			defer_save = {}, -- vim events that trigger a deferred save (saves after `debounce_delay`)

			cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
		},
	},
	config = true,
}
