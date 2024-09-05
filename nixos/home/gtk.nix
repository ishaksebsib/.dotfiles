{ pkgs, ... }:
{
  gtk = {
    enable = true;

		cursorTheme = {
			name = "Vanilla-DMZ";
			package = pkgs.vanilla-dmz;
			size = 30;
		};

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
}
