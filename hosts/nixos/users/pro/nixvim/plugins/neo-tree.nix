{ ... }:
{
  plugins.neo-tree = {
    enable = true;
  };

  extraConfigLua = ''
    vim.keymap.set("n", "<leader>e", "<CMD>Neotree reveal float toggle<CR>", { desc = "Neotree toggle from current buffer" })
    vim.keymap.set("n", "<leader>E", "<CMD>Neotree float toggle<CR>", { desc = "Neotree toggle" })
  '';
}
