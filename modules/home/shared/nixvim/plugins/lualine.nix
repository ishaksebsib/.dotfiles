{ ... }:
{
  plugins.lualine = {
    enable = true;
    settings = {
      options.theme = "auto";
      sections = {
        lualine_c = [
          {
            __unkeyed = "filename";
            path = 1;
          }
        ];
      };
    };
  };

  extraConfigLua = ''
    vim.keymap.set("n", "L", "<CMD>bnext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "H", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>w", "<CMD>bdelete<CR>", { desc = "Delete buffer" })
  '';
}
