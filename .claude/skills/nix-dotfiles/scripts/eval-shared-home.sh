#!/usr/bin/env bash
# Evaluate flake.homeModules.shared as a standalone home-manager config for a given
# system, so portability can be checked without that machine (e.g. no Mac needed).
# Usage: eval-shared-home.sh [system]   (default: aarch64-darwin)
# Prints the activation package drvPath on success; Nix's error otherwise.
set -euo pipefail

system="${1:-aarch64-darwin}"
repo="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"

case "$system" in
  *-darwin) home="/Users/pro" ;;
  *) home="/home/pro" ;;
esac

nix eval --impure --raw --expr "
let
  f = builtins.getFlake (toString $repo);
  system = \"$system\";
  inputs = f.inputs // { self = f; };
  perSystem = builtins.mapAttrs
    (_: i: (i.legacyPackages.\${system} or { }) // (i.packages.\${system} or { })) inputs;
  pkgs = import f.inputs.nixpkgs { inherit system; config.allowUnfree = true; };
in
(f.inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = { inherit inputs perSystem; flake = f; };
  modules = [
    f.homeModules.shared
    {
      home.username = \"pro\";
      home.homeDirectory = \"$home\";
      home.stateVersion = \"26.05\";
      home.enableNixpkgsReleaseCheck = false;
    }
  ];
}).activationPackage.drvPath"
echo
