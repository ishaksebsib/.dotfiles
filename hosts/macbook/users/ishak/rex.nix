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
  targets.darwin.defaults."com.superlogical.rex".SUEnableAutomaticChecks = false;

  # herdr's keybindings, the Rex way
  xdg.configFile."rex/init.lua".source = ../../../../bare/rex/init.lua;

  # Rex doesn't watch its config; reload a running server, never start one
  home.activation.rexConfigReload = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${rex} --autostart=false config reload 2>/dev/null || true
  '';
}
