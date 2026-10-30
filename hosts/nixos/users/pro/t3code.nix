{ perSystem, ... }:
{
  home.packages = [
    perSystem.self.t3code
  ];
}
