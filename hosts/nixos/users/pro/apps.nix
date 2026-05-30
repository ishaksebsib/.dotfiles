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
    protonvpn-gui
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
