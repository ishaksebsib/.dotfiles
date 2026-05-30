{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cloc
    just
    stow
    less
    lazygit
    ripgrep
    xclip
    tree
    ncdu
    p7zip
    wtype
    unzip
    zoxide
  ];
}
