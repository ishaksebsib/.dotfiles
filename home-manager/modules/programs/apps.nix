{ pkgs, ... }:
{
  home.packages = with pkgs; [
    antigravity
    windsurf
    obsidian
    telegram-desktop
    uget
    transmission_4-gtk
    obs-studio
    nautilus
  ];
}
