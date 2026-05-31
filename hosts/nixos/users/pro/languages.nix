{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gcc
    lua
    nodejs
    typescript

    # Formatters (used by conform.nvim)
    stylua
    black
    isort
    oxlint
  ];
}
