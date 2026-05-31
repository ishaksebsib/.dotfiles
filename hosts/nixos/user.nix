{ config, pkgs, ... }:
{
  users.users.pro = {
    isNormalUser = true;
    description = "ishak sebsib";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
