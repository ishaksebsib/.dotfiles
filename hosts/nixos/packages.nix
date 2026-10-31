{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    vim
  ];
}
