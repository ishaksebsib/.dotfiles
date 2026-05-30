{ pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./gh.nix
    ./apps.nix
    ./cli.nix
    ./languages.nix
    ./gtk.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  
  home.stateVersion = "26.05";
}
