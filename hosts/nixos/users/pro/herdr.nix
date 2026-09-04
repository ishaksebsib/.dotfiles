{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.herdr
    pkgs.bun
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
    remove_worktree = "prefix+shift+backspace"

    [ui.toast]
    enabled = true
    delivery = "system"
    delay_seconds = 1

		# PLUGIN SETTINGS
		

		# PLANNOTATOR LITE PLUGIN
		# https://github.com/plannotator/herdr-annotate

    [[keys.command]]
    key = "prefix+a"
    type = "plugin_action"
    command = "annotate.capture"
    description = "annotate text"

    [[keys.command]]
    key = "prefix+shift+a"
    type = "plugin_action"
    command = "annotate.copy-context"
    description = "copy annotations as context"

    [[keys.command]]
    key = "prefix+m"
    type = "plugin_action"
    command = "annotate.manage"
    description = "manage annotations"
  '';
}
