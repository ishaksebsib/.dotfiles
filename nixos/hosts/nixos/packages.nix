{ config, pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    vscode
    git
    wget
  ];
}
