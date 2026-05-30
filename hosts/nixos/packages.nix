{ config, pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vscode
    git

    # System tools
    curl
    wget
  ];
}
