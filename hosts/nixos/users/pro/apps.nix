{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    uget
    shotcut
    obs-studio
    nautilus
    google-chrome
    vlc
    gnome-system-monitor
    postman
    proton-vpn
    networkmanagerapplet
    transmission_4-gtk
  ];

  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      "smooth-scroll" = true;
      "selection-clipboard" = "clipboard";
    };
  };

  services.network-manager-applet.enable = true;
}
