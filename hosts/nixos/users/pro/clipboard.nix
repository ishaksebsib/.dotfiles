# Wayland/X11 clipboard and input tools (Linux desktop only).
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    xclip
    wtype
  ];
}
