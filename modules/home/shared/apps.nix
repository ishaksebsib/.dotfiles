{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    shotcut
    google-chrome
    postman
  ];

  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      "smooth-scroll" = true;
      "selection-clipboard" = "clipboard";
    };
  };
}
