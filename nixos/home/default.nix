{ config, pkgs, ... }:

{
	imports = [
	 ./tmp.nix
	 ./git.nix
	 ./gtk.nix
	 ./qt.nix
	 ./languages.nix
	 ./zsh.nix
	 ./zathura.nix
	 ./tmux.nix
	];
	home.username = "pro";
	home.homeDirectory = "/home/pro";

	home.packages = with pkgs; [
		 # libs
		 mesa
	   # cli tools
	   fzf
	   stow
	   neofetch
	   tmux
		 lazygit


	   # apps
	   alacritty
	   google-chrome
	   libreoffice
		 #evince
		 vlc
		 wsysmon
		 protonvpn-gui
		 insomnia
		 telegram-desktop
		 mattermost-desktop
		 yazi
		 uget
     transmission_4-gtk


		# Thunar file manager and plugins
		xfce.thunar
		xfce.thunar-volman
		xfce.thunar-archive-plugin
		xfce.thunar-media-tags-plugin

	];


	programs.home-manager.enable = true;
  programs.obs-studio.enable = true;
	programs. neovim = { enable = true; defaultEditor = true; }; 
  home.sessionVariables = {
    TERMINAL = "alacritty";
    DEFAULT_TERMINAL = "alacritty";
  };

	home.stateVersion = "23.11";
}
