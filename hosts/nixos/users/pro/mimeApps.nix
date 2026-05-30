{ ... }:
{
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = "google-chrome.desktop";
    "text/markdown" = "org.pwmt.zathura.desktop";
    "x-scheme-handler/http" = "google-chrome.desktop";
    "x-scheme-handler/https" = "google-chrome.desktop";
    "x-scheme-handler/about" = "google-chrome.desktop";
    "x-scheme-handler/unknown" = "google-chrome.desktop";
    "application/pdf" = "org.pwmt.zathura.desktop";
    "x-scheme-handler/postman" = "Postman.desktop";
    "application/epub+zip" = "org.pwmt.zathura.desktop";
    "text/plain" = "nvim.desktop";
    "x-terminal-emulator" = "alacritty.desktop";
    "inode/directory" = "org.gnome.Nautilus.desktop";
    "application/x-extension-htm" = "google-chrome.desktop";
    "application/x-extension-html" = "google-chrome.desktop";
    "application/x-extension-shtml" = "google-chrome.desktop";
    "application/xhtml+xml" = "google-chrome.desktop";
    "application/x-extension-xhtml" = "google-chrome.desktop";
    "application/x-extension-xht" = "google-chrome.desktop";
  };
  xdg.mimeApps.associations.added = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "text/markdown" = "org.pwmt.zathura.desktop";
  };
}
