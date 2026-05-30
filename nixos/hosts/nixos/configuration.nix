{ config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nixpkgs.nix
    ./user.nix
    ./desktop.nix
    ./services.nix
    ./packages.nix
  ];

  system.stateVersion = "25.11";
}
