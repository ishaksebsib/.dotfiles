{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;

    settings = {
      command = "${pkgs.fish}/bin/fish";

      "window-padding-x" = 0;
      "window-padding-y" = 0;
      "window-padding-balance" = true;
      "window-decoration" = "none";
      "background-opacity" = 1;

      "working-directory" = "home";
      "window-inherit-working-directory" = true;
      "resize-overlay" = "never";
      "confirm-close-surface" = false;

      "keybind" = "ctrl+enter=unbind";

      "font-size" = 11;
      "font-family" = "JetBrainsMono Nerd Font Mono";
      "font-family-bold" = "JetBrainsMono Nerd Font Mono";
      "font-family-italic" = "JetBrainsMono Nerd Font Mono";
      "font-family-bold-italic" = "JetBrainsMono Nerd Font Mono";
      "font-style" = "Bold";
      "font-style-bold" = "Bold";
      "font-style-italic" = "SemiBold Italic";
      "font-style-bold-italic" = "Bold Italic";

      "window-theme" = "dark";
      theme = "Catppuccin Macchiato";

      # Gruvbox Dark Hard
      # "background" = "#1d2021";
      # "foreground" = "#ebdbb2";
      # palette = [
      #   "0=#282828"
      #   "1=#cc241d"
      #   "2=#98971a"
      #   "3=#d79921"
      #   "4=#458588"
      #   "5=#b16286"
      #   "6=#689d6a"
      #   "7=#a89984"
      #   "8=#928374"
      #   "9=#fb4934"
      #   "10=#b8bb26"
      #   "11=#fabd2f"
      #   "12=#83a598"
      #   "13=#d3869b"
      #   "14=#8ec07c"
      #   "15=#ebdbb2"
      # ];
    };
  };
}
