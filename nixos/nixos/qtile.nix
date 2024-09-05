{ config, lib, pkgs, modulesPath, ... }:

{
	services.xserver.enable = true;
	services.xserver.layout = "us";
	services.xserver.windowManager.qtile.enable = true;
  programs.dconf.enable = true;
}
