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

	  
	fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-emoji
			monaspace
			(nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
		];

		fontconfig = {
					defaultFonts = {
						monospace = [ "Fira Code Nerd Font"];
					};
		};

	};


	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
}
