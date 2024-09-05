{ config, pkgs, ... }:

{
	imports = [
	 ./git.nix
	];
	home.username = "pro";
	home.homeDirectory = "/home/pro";

	home.packages = with pkgs; [
	   # cli tools
	   fzf
	   stow
	   neovim
	   neofetch
	   tmux
	   zsh

	   # apps
	   alacritty
	   google-chrome
	   libreoffice
	];

	  
	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
}
