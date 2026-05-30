{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cloc
    just
    less
    lazygit
    ripgrep
    xclip
    tree
    ncdu
    p7zip
    wtype
    unzip
  ];
}
