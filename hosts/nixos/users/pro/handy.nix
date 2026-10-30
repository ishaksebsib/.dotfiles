{ perSystem, ... }:
{
  home.packages = [
    perSystem.self.handy
  ];
}
