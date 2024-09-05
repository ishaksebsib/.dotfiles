{ pkgs, ... }:
{

nixpkgs.config.qt5 = {
  enable = true;
  platformTheme = "qt5ct"; 
    style = {
			name = "Adwaita-dark";
			package = pkgs.gnome.gnome-themes-extra;
    };
};

}
