{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      gs = "git status --short";
      j = "just";
      lg = "lazygit";
      nv = "nvim";
      rb = "sudo nixos-rebuild switch --flake $HOME/.dotfiles";
    };

    interactiveShellInit = ''
      set --global fish_color_command green

      bind \e accept-autosuggestion

      if test -f ~/.config/fish/.secrets.fish
          source ~/.config/fish/.secrets.fish
      end
    '';

    functions = {
      fish_greeting = "";
    };
  };

  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;
  programs.zoxide.options = [ "--cmd cd" ];
}
