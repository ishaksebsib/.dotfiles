{ config, pkgs, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  nix.channel.enable = false;

  # Weekly garbage collection: anything not reachable from a generation
  # newer than 14 days gets removed from the store.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
    randomizedDelaySec = "45min";
  };

  # Hardlink duplicate files in the store instead of keeping several copies.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
