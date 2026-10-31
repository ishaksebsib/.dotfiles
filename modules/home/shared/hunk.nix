{ perSystem, ... }:
{
  home.packages = [
    perSystem.self.hunk
  ];
}
