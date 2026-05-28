{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    uv
    gcc
    lua
    sassc
    typescript
  ];
}
