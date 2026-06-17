{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.herdr
    pkgs.libnotify
  ];

  xdg.configFile."herdr/config.toml".text = ''
    		onboarding = false

        [terminal]
        default_shell = "${pkgs.fish}/bin/fish"

        [keys]
        prefix = "super+a"
        switch_tab = "ctrl+1..9"
        switch_workspace = "prefix+1..9"
        focus_agent = "super+ctrl+1..9"

        [ui.toast]
        enabled = true
        delivery = "system"
        delay_seconds = 1
  '';
}
