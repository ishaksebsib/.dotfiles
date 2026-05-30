{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git

    # System tools
    curl
    wget
  ];
}
