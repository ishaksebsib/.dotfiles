{ lib, perSystem, ... }:
{
  # packaged for x86_64-linux and aarch64-darwin only
  home.packages = lib.optionals (perSystem.self ? handy) [
    perSystem.self.handy
  ];
}
