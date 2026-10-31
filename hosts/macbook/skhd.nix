# skhd hotkey daemon for the app launch keys (bare/skhd/skhdrc); OmniWM can't
# launch apps. Not nix-darwin's services.skhd: that runs skhd from the Nix
# store, which resets its Accessibility grant on every update.
#
# One-time manual step per machine: grant Accessibility to
# /usr/local/libexec/nix-skhd/skhd (and allow it to control Ghostty when asked).
{ lib, pkgs, ... }:
let
  skhdExe = lib.getExe pkgs.skhd;
  skhd = import ./stable-signed.nix { inherit lib pkgs; } {
    name = "skhd";
    exe = skhdExe;
  };
in
{
  system.activationScripts.preActivation.text = lib.mkAfter skhd.activation;

  launchd.user.agents.skhd.serviceConfig = {
    ProgramArguments = [
      skhd.path
      "-c"
      "${../../bare/skhd/skhdrc}"
    ];
    RunAtLoad = true;
    KeepAlive = true;
    ProcessType = "Interactive";
    # unused by skhd: changes the plist when the package does, so the agent
    # restarts onto the newly signed binary
    EnvironmentVariables.SKHD_STORE_PATH = skhdExe;
  };
}
