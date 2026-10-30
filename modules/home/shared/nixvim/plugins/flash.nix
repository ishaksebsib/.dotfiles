{ ... }:
{
  plugins.flash = {
    enable = true;
    settings = { };
  };

  extraConfigLua = ''
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end, { desc = "Flash" })

    vim.keymap.set({ "n", "x", "o" }, "S", function()
      require("flash").treesitter()
    end, { desc = "Flash Treesitter" })
  '';
}
