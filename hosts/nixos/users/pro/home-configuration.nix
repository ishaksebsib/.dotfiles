{ flake, ... }:
{
  imports = [
    flake.homeModules.shared
    ./apps.nix
    ./obs.nix
    ./rustdesk.nix
    ./claude-desktop.nix
    ./clipboard.nix
    ./gtk.nix
    ./hyprland.nix
    ./mimeApps.nix
    ./wofi.nix
    ./waybar.nix
  ];

  programs.home-manager.enable = true;

  programs.git.signing.key = "921099A4B90623CA";

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";
}
