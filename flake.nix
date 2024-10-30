{
	description = "ishak's nixos config";

	inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	  home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {

      nixosConfigurations = {
        pro = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos ];
        };
      };

      homeConfigurations = {
        "pro@pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home ];
        };
      };
    };
}
