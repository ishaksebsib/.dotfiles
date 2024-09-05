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

		 #managers
		 gnome.nautilus

	   # apps
	   alacritty
	   google-chrome
	   libreoffice
		 vlc
		 sysmontask
		 protonvpn-gui
		 postman
		 telegram-desktop
		 mattermost-desktop
	];

	  
	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
}
