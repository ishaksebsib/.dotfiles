{
	description = "ishak's nixos config";

	inputs = {
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	  home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	

	outputs = inputs@{ nixpkgs, home-manager, ... }: {
		nixosConfigurations = {
		  pro = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./nixos/default.nix
				
				home-manager.nixosModules.home-manager 
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.pro = import ./home/default.nix;
					home-manager.extraSpecialArgs = { inherit inputs; };				
				}
				];
			};
		};

	};

}
