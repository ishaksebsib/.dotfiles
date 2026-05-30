{ pkgs, ... }:
{
  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    font = {
      name = "CaskaydiaMono Nerd Font Propo Bold";
      size = 12;
      package = pkgs.nerd-fonts.caskaydia-mono;
    };

    gtk3.extraConfig = {
      gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  xdg.configFile."gtk-3.0/bookmarks".text = ''
    file:///home/pro/Development Development
    file:///home/pro/Downloads Downloads
    file:///home/pro/Documents Documents
  '';

  xdg.configFile."gtk-4.0/bookmarks".text = ''
    file:///home/pro/Development Development
    file:///home/pro/Downloads Downloads
    file:///home/pro/Documents Documents
  '';
}
