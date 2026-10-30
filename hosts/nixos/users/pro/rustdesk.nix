{ perSystem, ... }:
{
  home.packages = [
    perSystem.self.rustdesk
  ];
}
