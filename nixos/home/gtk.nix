{ pkgs, ... }:
{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "BreezeX Dark";
      package = pkgs.vanilla-dmz;
      size = 30;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
