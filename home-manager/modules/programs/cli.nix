{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Network
    curl
    wget

    # Power Management
    tlp

    # cli tools
    brightnessctl
    bluez
    blueman
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
