{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		#cmake
		#gnumake42
		#cxxtest
		#boost
		#guile
		#boost.dev
	];
}
