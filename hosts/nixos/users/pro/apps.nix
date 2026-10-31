{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uget
    nautilus
    gnome-system-monitor
    proton-vpn
    networkmanagerapplet
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
