{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		gcc
		cargo
		rustc
		go
		typescript
		nodejs_22
		python312Packages.pip
		python312Packages.ipython
	];
}
