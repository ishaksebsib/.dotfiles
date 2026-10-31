{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cloc
    less
    lazygit
    ripgrep
    tree
    ncdu
    p7zip
    unzip
    wget
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
