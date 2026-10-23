{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.t3code
  ];
}
