{ pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./gh.nix
    ./apps.nix
    ./obs.nix
    ./handy.nix
    ./herdr.nix
    ./hunk.nix
    ./rustdesk.nix
    ./claude-desktop.nix
    ./paper.nix
    ./t3code.nix
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
    ./nix-index.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";
}
