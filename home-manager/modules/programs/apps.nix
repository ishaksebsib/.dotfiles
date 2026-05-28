{ pkgs, ... }:
{
  home.packages = with pkgs; [
    antigravity
    obsidian
    telegram-desktop
    uget
    transmission_4-gtk
    obs-studio
    nautilus
  ];
}
