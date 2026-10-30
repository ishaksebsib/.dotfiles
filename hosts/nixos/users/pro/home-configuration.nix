{ flake, ... }:
{
  imports = [
    flake.homeModules.shared
    ./apps.nix
    ./obs.nix
    ./handy.nix
    ./herdr.nix
    ./hunk.nix
    ./rustdesk.nix
    ./claude-desktop.nix
    ./t3code.nix
    ./antigravity-hub.nix
    ./clipboard.nix
    ./gtk.nix
    ./hyprland.nix
    ./mimeApps.nix
    ./wofi.nix
    ./waybar.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";
}
