{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    uv
    gcc
    lua
    sassc
    nodejs
    typescript

    # Formatters (used by conform.nvim)
    stylua
    black
    isort
    oxlint
  ];
}
