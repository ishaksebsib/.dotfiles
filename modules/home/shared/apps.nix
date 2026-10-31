{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    google-chrome
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
