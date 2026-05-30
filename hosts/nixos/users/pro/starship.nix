{ pkgs, ... }:
let
  star = v: "\${${v}}";
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = "$directory$git_branch$git_status$fill$rust$elm$python$lua$nodejs$golang$haskell$package$aws$docker_context$jobs$cmd_duration$line_break$character";
      add_newline = true;
      palette = "custom";

      directory = {
        style = "bold fg:dark_blue";
        format = "[$path ]($style)";
        truncation_length = 2;
        truncation_symbol = "…/";
        truncate_to_repo = false;
      };

      git_branch = {
        style = "fg:green";
        symbol = " ";
        format = "[on](white) [$symbol$branch ]($style)";
      };

      git_status = {
        style = "fg:green";
        ahead = "⇡${star "count"}";
        diverged = "⇕ ⇡${star "ahead_count"} ⇣${star "behind_count"}";
        behind = "⇣${star "count"}";
        format = "([${star "all_status"}${star "ahead_behind"}]($style) )";
      };

      fill.symbol = ".";

      cmd_duration = {
        min_time = 0;
        style = "fg:green";
        format = "[ ⌛${star "duration"}]($style)";
      };

      palettes.custom = {
        dark_blue = "#458588";
        blue = "#83a598";
        teal = "#8ec07c";
        red = "#fb4934";
        orange = "#fe8019";
        green = "#b8bb26";
        yellow = "#fabd2f";
        purple = "#d3869b";
        gray = "#928374";
        black = "#282828";
        white = "#ebdbb2";
      };

      # My custom palette (uncomment to use)
      # palettes.custom = {
      #   dark_blue = "#4a88e4";
      #   blue = "#4a88e4";
      #   teal = "#23acdd";
      #   red = "#e25d56";
      #   orange = "#D08770";
      #   green = "#1ba63f";
      #   yellow = "#e9bf57";
      #   purple = "#915caf";
      #   gray = "#434C5E";
      #   black = "#2E3440";
      #   white = "#f0f0f0";
      # };
    };
  };
}
