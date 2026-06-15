{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.herdr
  ];

  xdg.configFile."herdr/config.toml".text = ''
    [terminal]
    default_shell = "${pkgs.fish}/bin/fish"

    [keys]
    prefix = "super+a"
    switch_tab = "ctrl+1..9"
    switch_workspace = "prefix+1..9"
  '';
}
