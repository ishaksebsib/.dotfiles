{ pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-mono
  ];
  fonts.fontconfig.enable = true;
}
