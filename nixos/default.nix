# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
			./power-management.nix
			./env.nix
			./audio.nix
			./bluetooth.nix
      ./qtile.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pro"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Addis_Ababa";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pro = {
    isNormalUser = true;
    description = "pro";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

	# Run unpatched dynamic binaries on NixOS
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		# missing dynamic libraries for unpackaged software
		zlib
	];

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # ENABLE FLAKES
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

		 #network
		 curl
     wget
     networkmanagerapplet

		 #cli tools
		 ripgrep
		 xclip
		 tree
		 ncdu
		 p7zip
		 unzip   
		
		 #libs

	 # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
		(let base = pkgs.appimageTools.defaultFhsEnvArgs; in
			pkgs.buildFHSUserEnv {
				name = "fhs";
				targetPkgs = pkgs: (
					base.targetPkgs pkgs ++ [
						pkgs.pkg-config
						pkgs.ncurses
						pkgs.zlib
					]
				);
				profile = "export FHS=1";
				runScript = "zsh";
				extraOutputsToInstall = [ "bin" "lib" "dev" ];  # Use common outputs or omit this line if unnecessary
			})

  ];

	services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
	
	fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-emoji
			font-awesome
			monaspace
			(nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
		];
		fontconfig = {
					defaultFonts = {
						monospace = [ "JetBrainsMono Nerd Font"];
					};
		};
	};

  virtualisation.docker = {
    enable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
