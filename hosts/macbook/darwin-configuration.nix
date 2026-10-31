{ flake, hostName, ... }:
{
  imports = [
    flake.modules.common.nix
    flake.modules.common.fonts
    flake.modules.common.home-manager
    flake.modules.common.tailscale
    ./user.nix
    ./security.nix
    ./dock.nix
    ./chrome.nix
    ./keyboard.nix
    ./kanata.nix
    ./skhd.nix
    ./applications.nix
    ./windows.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = hostName;

  system.stateVersion = 7;
}
