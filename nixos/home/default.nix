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
		 vimPlugins.LazyVim	


	   # apps
	   alacritty
	   google-chrome
	   libreoffice
		 vlc
		 #sysmontask
		 protonvpn-gui
		 postman
		 telegram-desktop
		 mattermost-desktop
		 nautilus
	];

	  
	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
}
