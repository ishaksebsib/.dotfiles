{
  perSystem,
  pkgs,
  lib,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  # keys.json replaces every binding, so it starts from the full set the app
  # ships (bare/herdr-app, copied from the release's defaults/). Re-copy them
  # when bumping herdr-app.
  shipped = lib.importJSON (
    if isDarwin then ../../../bare/herdr-app/keys.macos.json else ../../../bare/herdr-app/keys.json
  );

  # The terminal herdr's keymap (its defaults plus herdr.nix) as two-key
  # sequences after the same prefix. Tabs on Caps+1..9 are already the shipped
  # default on both OSes. Not in the app: worktrees, focus agent by number,
  # rename pane, scrollback editing, copy and resize modes, pane cycling.
  prefix = if isDarwin then "cmd-a" else "super-a";
  herdrKeys = {
    # Linux reports Shift+/ as ?, so both spellings
    "?" = "app.help";
    "shift-/" = "app.help";
    "s" = "app.settings";
    "shift-n" = "space.new";
    "shift-w" = "space.rename";
    "shift-d" = "space.close";
    # workspace picker and session navigator: the app's go-to-a-tab picker
    "w" = "mod.open:picker";
    "g" = "mod.open:picker";
    # detach: the window closes, its terminals keep running in herdr-core
    "q" = "window.close";
    "o" = "agent.next";
    "c" = "tab.new";
    "shift-t" = "tab.rename";
    "shift-x" = "tab.close";
    "p" = "tab.prev";
    "n" = "tab.next";
    "h" = "pane.go:left";
    "j" = "pane.go:down";
    "k" = "pane.go:up";
    "l" = "pane.go:right";
    "shift-h" = "pane.swap:left";
    "shift-j" = "pane.swap:down";
    "shift-k" = "pane.swap:up";
    "shift-l" = "pane.swap:right";
    "v" = "pane.split:right";
    "-" = "pane.split:down";
    "x" = "pane.close";
    "z" = "pane.zoom";
    "b" = "layout.toggle:sidebar";
  }
  # switch_workspace in herdr.nix
  // lib.genAttrs' (lib.range 1 9) (n: lib.nameValuePair (toString n) "space.select:${toString n}");

  keys = shipped // {
    # the shipped Ctrl/Alt+1..9 space keys go back to programs
    global =
      lib.filterAttrs (_: action: !lib.hasPrefix "space.select:" action) shipped.global
      // lib.mapAttrs' (key: lib.nameValuePair "${prefix} ${key}") herdrKeys;
  };
in
{
  # the app runs its terminals in herdr-core, found on PATH; a Nix-owned core
  # is never updated by the app
  home.packages = [
    perSystem.self.herdr-app
    perSystem.self.herdr-core
  ];

  # settings.json stays the app's: Settings and the zoom keys write to it
  xdg.configFile."herdr-app/keys.json".source = (pkgs.formats.json { }).generate "keys.json" keys;

  # new terminals run fish, like default_shell in herdr.nix
  xdg.configFile."herdr-core/config.toml".text = ''
    shell = ["${pkgs.fish}/bin/fish"]
  '';
}
