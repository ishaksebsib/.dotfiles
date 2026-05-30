{ pkgs, ... }:
{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./colorscheme.nix
    ./plugins/lsp.nix
    ./plugins/cmp.nix
    ./plugins/treesitter.nix
    ./plugins/telescope.nix
    ./plugins/neo-tree.nix
    ./plugins/harpoon.nix
    ./plugins/flash.nix
    ./plugins/gitsigns.nix
    ./plugins/conform.nix
    ./plugins/lualine.nix
    ./plugins/alpha.nix
    ./plugins/which-key.nix
    ./plugins/autopairs.nix
    ./plugins/ts-autotag.nix
    ./plugins/indent-blankline.nix
    ./plugins/colorizer.nix
    ./plugins/todo-comments.nix
    ./plugins/extra.nix
    ./plugins/terminal.nix
  ];

  plugins."web-devicons".enable = true;

  extraPlugins = [
    (pkgs.vimPlugins."vim-nix" or pkgs.vimPlugins.vim-nix)
  ];
}
