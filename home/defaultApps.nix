{ pkgs, lib, config, ... }:
{
 xdg.mimeApps = {
    enable = true;
    associations.added = {
		  #  terminal
			"x-scheme-handler/terminal" = ["alacritty.desktop"];

			# Document formats
      "application/pdf" = ["org.pwmt.zathura.desktop"];
			"application/epub+zip" = ["org.pwmt.zathura.desktop"];
			"application/postscript" = ["org.pwmt.zathura.desktop"];
      "application/vnd.comicbook-rar" = ["org.pwmt.zathura.desktop"];
    };
    defaultApplications = {
		  #  terminal
			"x-scheme-handler/terminal" = ["alacritty.desktop"];

			# Web-related
			"text/html" = ["google-chrome.desktop"];
			"application/xhtml+xml" = ["google-chrome.desktop"];
			"x-scheme-handler/http" = ["google-chrome.desktop"];
			"x-scheme-handler/https" = ["google-chrome.desktop"];
			"x-scheme-handler/about" = ["google-chrome.desktop"];
			"x-scheme-handler/unknown" = ["google-chrome.desktop"];

			# Document formats
      "application/pdf" = ["org.pwmt.zathura.desktop"];
			"application/epub+zip" = ["org.pwmt.zathura.desktop"];
			"application/postscript" = ["org.pwmt.zathura.desktop"];
      "application/vnd.comicbook-rar" = ["org.pwmt.zathura.desktop"];
    };
  };
}
