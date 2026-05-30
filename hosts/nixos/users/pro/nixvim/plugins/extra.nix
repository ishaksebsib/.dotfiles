{ pkgs, ... }:
{
  # Plugins without native nixvim modules, loaded via extraPlugins + extraConfigLua

  extraPlugins = [
    pkgs.vimPlugins.nerdcommenter
    (pkgs.vimPlugins."auto-save-nvim" or pkgs.vimPlugins.autoSaveNvim)
    (pkgs.vimPlugins."fff-nvim" or pkgs.vimPlugins.fffNvim)
    (pkgs.vimPlugins."supermaven-nvim" or pkgs.vimPlugins.supermavenNvim)
  ];

  extraConfigLua = ''
    -- Auto-save
    require("auto-save").setup({
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
        defer_save = { "InsertLeave" },
        cancel_deferred_save = { "InsertEnter" },
      },
    })

    -- fff.nvim
    require("fff").setup({})

    vim.keymap.set("n", "<leader>f", function()
      require("fff").find_files()
    end, { desc = "Open file picker" })

    vim.keymap.set("n", "<leader>/", function()
      require("fff").live_grep({
        grep = {
          modes = { "fuzzy", "plain" },
        },
      })
    end, { desc = "Live fuzzy grep" })

    -- supermaven-nvim (currently disabled)
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        accept_word = "<S-Tab>",
        clear_suggestion = "<C-]>",
      },
      condition = function()
        return false
      end,
    })
  '';
}
