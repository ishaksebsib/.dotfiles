{ config, pkgs, ... }:

{
	imports = [
	 ./dotfiles.nix
	 ./defaultApps.nix
	 ./env.nix
	 ./terminals.nix
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
		 google-chrome
		 obsidian
		 syncthing
	   libreoffice
		 #evince
		 vlc
		 wsysmon
		 insomnia
		 telegram-desktop
		 mattermost-desktop
		 yazi
		 uget
     transmission_4-gtk
		 obs-studio

		 # Thunar file manager and plugins
		 xfce.thunar
		 xfce.thunar-volman
		 xfce.thunar-archive-plugin
		 xfce.thunar-media-tags-plugin

		
		 # shell scripts
		 (import ./scripts/open.nix { inherit pkgs; })
		 (import ./scripts/toggle-keyboard.nix { inherit pkgs; })

	];

	programs.neovim = { 
		enable = true; 
		defaultEditor = true; 

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

	}; 

	home.stateVersion = "24.05";
	programs.home-manager.enable = true;

}
