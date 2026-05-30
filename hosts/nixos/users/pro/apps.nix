{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    uget
    obs-studio
    nautilus
    google-chrome
    vlc
    mission-center
    postman
    proton-vpn
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
