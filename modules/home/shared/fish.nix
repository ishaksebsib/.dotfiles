{ pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
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

      # open herdr in its own Ghostty window, then close this shell
      h =
        let
          args = ''--config-default-files=false --config-file="$HOME/.config/ghostty/herdr" -e herdr'';
        in
        if isDarwin then
          # the ghostty CLI cannot open windows on macOS, so start a new app instance
          ''
            open -na Ghostty --args ${args}
            exit
          ''
        else
          ''
            command ghostty ${args} &
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
