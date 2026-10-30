{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    nixpkgs.source = inputs.nixpkgs;

    imports = [
      ./nixvim/default.nix
    ];
  };

  home.sessionVariables.EDITOR = "nvim";
}
