{ perSystem, ... }:
{
  home.packages = [
    perSystem.self.claude-desktop
  ];
}
