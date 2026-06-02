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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
