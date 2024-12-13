{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		gcc
		go
		docker-compose
		typescript
		nodejs_22
		prettierd
		python312Packages.pip
		python312Packages.ipython
		elixir_1_15

		# Rust
		cargo
		rustc
	  openssl
	  pkg-config
		rust-analyzer

	];

}
