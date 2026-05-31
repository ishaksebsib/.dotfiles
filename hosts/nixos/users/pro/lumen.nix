{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.lumen.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
