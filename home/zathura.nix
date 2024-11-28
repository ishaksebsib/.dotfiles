{ pkgs, lib, config, ... }:
{
  programs.zathura = {
    enable = true;
		options = {
					recolor = "true";
					smooth-scroll = "true";
					selection-clipboard = "clipboard";
				};
  };
}
