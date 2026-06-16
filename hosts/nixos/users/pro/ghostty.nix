{ pkgs, ... }:
{
  xdg.configFile = {
    "ghostty/base".text = ''
      command = ${pkgs.fish}/bin/fish

      window-padding-x = 0
      window-padding-y = 0
      window-padding-balance = true
      window-decoration = none
      background-opacity = 1

      working-directory = home
      window-inherit-working-directory = true
      resize-overlay = never
      confirm-close-surface = false

      keybind = ctrl+enter=unbind

      font-size = 11
      font-family = JetBrainsMono Nerd Font Mono
      font-family-bold = JetBrainsMono Nerd Font Mono
      font-family-italic = JetBrainsMono Nerd Font Mono
      font-family-bold-italic = JetBrainsMono Nerd Font Mono
      font-style = Bold
      font-style-bold = Bold
      font-style-italic = SemiBold Italic
      font-style-bold-italic = Bold Italic

      window-theme = dark
    '';

    "ghostty/gruvbox".text = ''
      # Gruvbox Dark Hard
      background = #1d2021
      foreground = #ebdbb2
      palette = 0=#282828
      palette = 1=#cc241d
      palette = 2=#98971a
      palette = 3=#d79921
      palette = 4=#458588
      palette = 5=#b16286
      palette = 6=#689d6a
      palette = 7=#a89984
      palette = 8=#928374
      palette = 9=#fb4934
      palette = 10=#b8bb26
      palette = 11=#fabd2f
      palette = 12=#83a598
      palette = 13=#d3869b
      palette = 14=#8ec07c
      palette = 15=#ebdbb2
    '';

    "ghostty/catppuccin".text = ''
      theme = Catppuccin Macchiato
    '';

    "ghostty/herdr".text = ''
      config-file = base
      config-file = catppuccin
    '';
  };

  programs.ghostty = {
    enable = true;

    settings = {
      "config-file" = [
        "base"
        "gruvbox"
      ];
    };
  };
}
