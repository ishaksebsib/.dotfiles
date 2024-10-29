{ config, lib, pkgs, modulesPath, ... }:

{
	services.xserver = {
		enable = true;
		windowManager.qtile.enable = true;
		layout = "us";
		xkbOptions = "caps:swapescape";
		libinput = {
			enable = true;
			touchpad = {
				naturalScrolling = true;
			};
		};
	};

  environment.systemPackages = with pkgs; [ 
     # qtileWM dep's
     rofi
     dunst
     picom
     brightnessctl
		 rofi-screenshot
     i3lock
     feh
	];

  programs.dconf.enable = true;
}
