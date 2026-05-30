{ ... }:
{
  plugins.conform = {
    enable = true;
    settings = {
      formatters_by_ft = {
        javascript = [ "oxfmt" ];
        javascriptreact = [ "oxfmt" ];
        json = [ "oxfmt" ];
        jsonc = [ "oxfmt" ];
        lua = [ "stylua" ];
        python = [ "isort" "black" ];
        typescript = [ "oxfmt" ];
        typescriptreact = [ "oxfmt" ];
      };
      default_format_opts = {
        lsp_format = "fallback";
      };
    };
  };

  extraConfigLua = ''
    vim.keymap.set("n", "=", function()
      require("conform").format({ async = true })
    end, { desc = "Format buffer" })
  '';
}
