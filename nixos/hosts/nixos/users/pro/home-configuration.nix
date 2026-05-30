{ pkgs, inputs, ... }:
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    kdePackages.kate
  ];
}
