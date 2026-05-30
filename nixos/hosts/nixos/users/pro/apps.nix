{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    uget
    obs-studio
    nautilus
  ];
}
