{
  perSystem,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    perSystem.self.herdr
    pkgs.bun
  ]
  # notify-send for herdr toasts; macOS uses its own notification center
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.libnotify ];

  xdg.configFile."herdr/config.toml".text = ''
        onboarding = false

        [terminal]
        default_shell = "${pkgs.fish}/bin/fish"

        [keys]
        prefix = "super+a"
        # Caps-hold: Ctrl on NixOS, Cmd (super) on macOS via kanata
        switch_tab = "${if pkgs.stdenv.hostPlatform.isDarwin then "super" else "ctrl"}+1..9"
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
