{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    wget
    vim
  ];
}
