{ pkgs, ... }:
{
  home.packages = [
    # built with the system pkgs (not inputs.self.packages) so nixpkgs.config.allowUnfree applies
    (import ../../../../packages/claude-desktop { inherit pkgs; })
  ];
}
