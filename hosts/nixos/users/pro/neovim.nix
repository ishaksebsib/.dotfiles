{ pkgs, ... }:
{
  home.packages = with pkgs; [ neovim ];

  home.sessionVariables.EDITOR = "nvim";

  home.file.".config/nvim/init.lua".source = ../../../../bare/nvim/init.lua;
  home.file.".config/nvim/lua".source     = ../../../../bare/nvim/lua;
}
