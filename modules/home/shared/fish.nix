{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      gs = "git status --short";
      j = "just";
      lg = "lazygit";
      nv = "nvim";
      rb =
        if isDarwin then
          "sudo darwin-rebuild switch --flake $HOME/.dotfiles"
        else
          "nixos-rebuild switch --sudo --flake $HOME/.dotfiles";
      ns = "nix develop --command fish";
    };

    interactiveShellInit = ''
      set --global fish_color_command green

      bind \e accept-autosuggestion
    '';

    functions = {
      fish_greeting = "";
    }
    // lib.optionalAttrs isLinux {
      # herdr is packaged for Linux only
      h = ''
        command ghostty --config-default-files=false --config-file="$HOME/.config/ghostty/herdr" -e herdr &
        disown
        exit
      '';
    };
  };

  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;
  programs.zoxide.options = [ "--cmd cd" ];
}
