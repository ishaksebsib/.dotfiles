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
    "x-terminal-emulator" = "ghostty.desktop";
    "inode/directory" = "org.gnome.Nautilus.desktop";
    "application/x-extension-htm" = "google-chrome.desktop";
    "application/x-extension-html" = "google-chrome.desktop";
    "application/x-extension-shtml" = "google-chrome.desktop";
    "application/xhtml+xml" = "google-chrome.desktop";
    "application/x-extension-xhtml" = "google-chrome.desktop";
    "application/x-extension-xht" = "google-chrome.desktop";
    "video/mp4" = "vlc.desktop";
    "video/mpeg" = "vlc.desktop";
    "video/ogg" = "vlc.desktop";
    "video/quicktime" = "vlc.desktop";
    "video/webm" = "vlc.desktop";
    "video/x-flv" = "vlc.desktop";
    "video/x-matroska" = "vlc.desktop";
    "video/x-m4v" = "vlc.desktop";
    "video/x-msvideo" = "vlc.desktop";
    "video/x-ms-wmv" = "vlc.desktop";
  };
  xdg.mimeApps.associations.added = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "text/markdown" = "org.pwmt.zathura.desktop";
  };
}
