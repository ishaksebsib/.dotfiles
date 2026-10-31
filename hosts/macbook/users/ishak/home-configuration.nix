{ flake, ... }:
{
  imports = [
    flake.homeModules.shared
    ./omniwm.nix
  ];

  programs.home-manager.enable = true;

  programs.git.signing.key = "EF5140C7E09D8071";

  # fish enables this by default, but on darwin home-manager uses the system
  # man (programs.man.package = null), so it only produces a warning
  programs.man.generateCaches = false;

  home.stateVersion = "26.05";
}
