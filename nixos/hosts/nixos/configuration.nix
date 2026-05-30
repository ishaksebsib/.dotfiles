{ config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./user.nix
    ./desktop.nix
    ./services.nix
    ./packages.nix
    ./fonts.nix
    ./home-manager.nix
  ];

  system.stateVersion = "25.11";
}
