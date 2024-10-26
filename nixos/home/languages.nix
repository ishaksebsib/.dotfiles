{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		gcc
		cargo
		rustc
		rust-analyzer
		go
		typescript
		nodejs_22
		prettierd
		python312Packages.pip
		python312Packages.ipython
	];
}
