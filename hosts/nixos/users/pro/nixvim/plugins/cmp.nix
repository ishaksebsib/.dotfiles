{ ... }:
{
  plugins = {
    cmp = {
      enable = true;
      settings = {
        snippet.expand.__raw = ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';
        window = {
          completion.__raw = "cmp.config.window.bordered()";
          documentation.__raw = "cmp.config.window.bordered()";
        };
        mapping = {
          "<C-b>".__raw = "cmp.mapping.scroll_docs(-4)";
          "<C-f>".__raw = "cmp.mapping.scroll_docs(4)";
          "<C-c>".__raw = "cmp.mapping.complete()";
          "<C-e>".__raw = "cmp.mapping.abort()";
          "<CR>".__raw = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
        ];
      };
    };

    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
      fromVscode = [
        { }
      ];
    };
  };
}
