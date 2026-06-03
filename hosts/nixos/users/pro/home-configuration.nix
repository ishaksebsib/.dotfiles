{ pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./gh.nix
    ./apps.nix
    ./handy.nix
    ./lumen.nix
    ./cli.nix
    ./gtk.nix
    ./neovim.nix
    ./hyprland.nix
    ./ghostty.nix
    ./fish.nix
    ./starship.nix
    ./mimeApps.nix
    ./wofi.nix
    ./waybar.nix
    ./llms.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";
}
