# Nix daemon settings shared by NixOS and nix-darwin hosts. The gc/optimise
# schedules differ per OS (`dates` vs launchd `interval`), so hosts set them.
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

  # Garbage collection: anything not reachable from a generation newer than
  # 14 days gets removed from the store.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # Hardlink duplicate files in the store instead of keeping several copies.
  nix.optimise.automatic = true;
}
