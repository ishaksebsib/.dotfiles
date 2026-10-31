# Stop Google's updater (Keystone/GoogleUpdater) from replacing the Nix-pinned
# Chrome, so Chrome only changes with the flake. This is Google's documented
# policy for Macs without MDM: https://support.google.com/chrome/a/answer/7591084
# (UpdateDefault 3 = "updates are never applied").
{ lib, pkgs, ... }:
let
  policy = pkgs.writeText "com.google.Keystone.plist" (
    lib.generators.toPlist { escape = true; } {
      updatePolicies."com.google.Chrome".UpdateDefault = 3;
    }
  );
in
{
  # A daemon rather than an activation script: it also rewrites the policy at
  # every boot, in case macOS clears unmanaged files from Managed Preferences.
  launchd.daemons.chrome-update-policy = {
    script = ''
      mkdir -p "/Library/Managed Preferences"
      install -m 644 -o root -g wheel ${policy} "/Library/Managed Preferences/com.google.Keystone.plist"
    '';
    serviceConfig.RunAtLoad = true;
  };
}
