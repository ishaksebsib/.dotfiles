# Cloudflare WARP (1.1.1.1), the menu bar app. Does what Cloudflare's .pkg
# installer does: the app goes into /Applications (system extensions only
# activate from there) and its root daemon runs from that copy. Cloudflare's
# separate updater service is left out: it only serves managed deployments.
#
# One-time per machine: open Cloudflare WARP, accept its terms and connect,
# then allow the VPN extension in System Settings > General > Login Items &
# Extensions when asked.
{ lib, pkgs, ... }:
let
  # nixpkgs strips the macOS binaries, which breaks the bundle's signature
  warp = pkgs.cloudflare-warp.overrideAttrs { dontFixup = true; };
  app = "/Applications/Cloudflare WARP.app";
  seal = "Contents/_CodeSignature/CodeResources";
in
{
  # preActivation: in place before nix-darwin reloads the launchd daemons
  system.activationScripts.preActivation.text = lib.mkAfter ''
    if ! ${lib.getExe' pkgs.diffutils "cmp"} -s "${warp}${app}/${seal}" "${app}/${seal}"; then
      echo "installing Cloudflare WARP ${warp.version}..."
      rm -rf "${app}"
      cp -R "${warp}${app}" "${app}"
      # Spotlight doesn't pick up the copy by itself
      /usr/bin/mdimport "${app}" || true
    fi
  '';

  # the label and settings of the installer's own LaunchDaemon plist
  launchd.daemons."com.cloudflare.1dot1dot1dot1.macos.warp.daemon".serviceConfig = {
    ProgramArguments = [ "${app}/Contents/Resources/CloudflareWARP" ];
    UserName = "root";
    RunAtLoad = true;
    KeepAlive = true;
    SoftResourceLimits.NumberOfFiles = 32768;
    # unused by WARP: changes the plist when the package does, so the daemon
    # restarts onto the newly copied app
    EnvironmentVariables.WARP_STORE_PATH = "${warp}";
  };
}
