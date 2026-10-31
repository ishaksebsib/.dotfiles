{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uget
    nautilus
    vlc
    gnome-system-monitor
    proton-vpn
    networkmanagerapplet
    transmission_4-gtk
  ];

  services.network-manager-applet.enable = true;
}
