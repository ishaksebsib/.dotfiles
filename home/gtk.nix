{ pkgs, ... }:
{

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

		theme = {
				name = "Adwaita-dark";
				package = pkgs.gnome.gnome-themes-extra;
		};

		gtk3 = {
			extraConfig.gtk-application-prefer-dark-theme = true;
		};

  };

	home.pointerCursor = {
		name = "phinger-cursors-dark";
		package = pkgs.phinger-cursors;
		size = 12;
		gtk.enable = true;
	};

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
  };

}
