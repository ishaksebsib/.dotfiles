{ config, lib, pkgs, modulesPath, ... }:

{
	services.xserver.enable = true;
	services.xserver.layout = "us";
	services.xserver.windowManager.qtile.enable = true;
	services.xserver.xkbOptions = "caps:swapescape";
  programs.dconf.enable = true;


  environment.systemPackages = with pkgs; [ 
     # qtileWM dep's
     rofi
     dunst
     picom
     brightnessctl
     flameshot # for screen shoot
     i3lock
     feh
	];
}
