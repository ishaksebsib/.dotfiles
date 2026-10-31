{ flake, ... }:
{
  imports = [
    flake.homeModules.shared
    ./omniwm.nix
    ./wallpaper.nix
    ./flameshot.nix
  ];

  programs.home-manager.enable = true;

  programs.git.signing.key = "EF5140C7E09D8071";

  # fish enables this by default, but on darwin home-manager uses the system
  # man (programs.man.package = null), so it only produces a warning
  programs.man.generateCaches = false;

  # hides the "Last login" line /usr/bin/login prints in every new terminal
  home.file.".hushlogin".text = "";

  home.stateVersion = "26.05";
}
