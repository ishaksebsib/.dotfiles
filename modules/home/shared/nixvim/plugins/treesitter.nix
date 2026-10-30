{ ... }:
{
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };

  extraConfigLua = ''
    vim.filetype.add({
      extension = {
        metta = "scheme",
      },
    })

    vim.filetype.add({
      extension = {
        hx = "hx",
      },
    })

    vim.treesitter.language.register("typescript", "hx")
  '';
}
