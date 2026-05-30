{ ... }:
{
  plugins.telescope = {
    enable = true;
    extensions = {
      ui-select = {
        enable = true;
        settings.__raw = "require('telescope.themes').get_dropdown({})";
      };
    };
  };

  extraConfigLua = ''
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "select currently open files" })
    vim.keymap.set("n", "<leader>td", "<CMD>TodoTelescope<CR>", { desc = "find todos" })
    vim.keymap.set("n", "<leader>th", builtin.colorscheme, { desc = "select themes" })
  '';
}
