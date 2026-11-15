# torrential and its engine, started at login so phones and TVs can reach it.
# From /nix/store it never updates itself, and it leaves a login service it
# didn't write alone, so this one (same label and unit name as its own,
# pointing at the current store path) replaces the one it would add.
{ perSystem, config, ... }:
let
  torrential = perSystem.self.torrential;
  run = [
    "${torrential}/bin/torrential"
    "daemon"
    "run"
    "--service"
  ];
  log = "${config.xdg.stateHome}/torrential/engine.log";
in
{
  home.packages = [ torrential ];

  launchd.agents.torrential = {
    enable = true;
    config = {
      Label = "dev.torrential.engine";
      ProgramArguments = run;
      RunAtLoad = true;
      KeepAlive.SuccessfulExit = false;
      StandardOutPath = log;
      StandardErrorPath = log;
    };
  };

  systemd.user.services.torrential = {
    Unit.Description = "torrential engine";
    Service = {
      ExecStart = toString run;
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
