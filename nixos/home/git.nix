{ pkgs, lib, config, ... }:

{
	programs.git = {
		enable = true;
		userName = "ishaksebsib";
		userEmail = "ishaksebsib@gmail.com";
		extraConfig.init.defaultBranch = "main";
  };
}
