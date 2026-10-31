# Portable home-manager configuration shared by every host (NixOS and macOS).
{
  imports = [
    ./git.nix
    ./gh.nix
    ./cli.nix
    ./neovim.nix
    ./ghostty.nix
    ./fish.nix
    ./starship.nix
    ./llms.nix
    ./nix-index.nix
    ./apps.nix
    ./herdr.nix
    ./hunk.nix
  ];
}
