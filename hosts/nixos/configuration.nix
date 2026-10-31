{ flake, ... }:
{
  imports = [
    flake.modules.common.nix
    flake.modules.common.fonts
    flake.modules.common.home-manager
    ./hardware.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./user.nix
    ./desktop.nix
    ./services.nix
    ./packages.nix
  ];

  system.stateVersion = "25.11";
}
