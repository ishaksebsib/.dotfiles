{
  perSystem,
  lib,
  ...
}:
let
  rex = lib.getExe perSystem.self.rex;
in
{
  home.packages = [ perSystem.self.rex ];

  # updates come from bumping packages/rex, not Sparkle
  # Rex keeps its terminal settings in the app's preferences (Settings >
  # Terminal), not in init.lua; these match Ghostty (modules/home/shared/ghostty.nix)
  targets.darwin.defaults."com.superlogical.rex" = {
    SUEnableAutomaticChecks = false;
    "Workspace.terminalFontName" = "JetBrainsMono Nerd Font Mono";
    "Workspace.terminalFontStyle" = "Bold";
    "Workspace.terminalFontPointSize" = 16.0;
  };

  # keybindings: Option+A prefix, then a tmux-style key
  xdg.configFile."rex/init.lua".source = ../../../../bare/rex/init.lua;

  # Rex doesn't watch its config; reload a running server, never start one
  home.activation.rexConfigReload = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${rex} --autostart=false config reload 2>/dev/null || true
  '';
}
