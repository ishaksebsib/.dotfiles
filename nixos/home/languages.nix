{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		gcc
		go
		typescript
		nodejs_22
		prettierd
		python312Packages.pip
		python312Packages.ipython
		#python312Packages.chromadb

		# Rust
		cargo
		rustc
	  openssl
	  pkg-config
		rust-analyzer

	];

}
