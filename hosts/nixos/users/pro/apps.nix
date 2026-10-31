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

  # Linux only: zathura's appstream dependency does not build on darwin
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      "smooth-scroll" = true;
      "selection-clipboard" = "clipboard";
    };
  };
}
