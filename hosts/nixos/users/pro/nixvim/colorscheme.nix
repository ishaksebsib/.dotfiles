{ ... }:
{
  colorschemes.catppuccin = {
    enable = true;
  };
  colorschemes.gruvbox = {
    enable = false;
    settings = {
      contrast = "hard";
      overrides = {
        NormalFloat = {
          bg = "#1d2021";
        };
        SignColumn = {
          bg = "#1d2021";
        };
      };
    };
  };
}
