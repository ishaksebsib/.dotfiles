{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		cmake
		cxxtest
		boost
		guile
	];
}
