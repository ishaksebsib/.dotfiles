{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {

      window = {
        dimensions = { columns = 0; lines = 0; };
        padding = { x = 0; y = 0; };
        opacity = 0.9;
        dynamic_padding = false;
        decorations = "None";
        startup_mode = "Windowed"; 
      };  

      font = {
        size = 10.999;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };

        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };

      # Colors (alabaster_dark)
      colors = {
        # Default colors
        primary = {
          background = "#0E1415";
          foreground = "#CECECE";
        };

        cursor = {
          text = "#0E1415";
          cursor = "#CECECE";
        };

        normal = {
          black = "#0E1415";
          red = "#e25d56";
          green = "#1ba63f";
          yellow = "#e9bf57";
          blue = "#4a88e4";
          magenta = "#915caf";
          cyan = "#23acdd";
          white = "#f0f0f0";
        };

        bright = {
          black = "#777777";
          red = "#f36868";
          green = "#88db3f";
          yellow = "#f0bf7a";
          blue = "#6f8fdb";
          magenta = "#e987e9";
          cyan = "#4ac9e2";
          white = "#FFFFFF";
        };
      };
    };
  };
}
