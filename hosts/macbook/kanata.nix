# Kanata keyboard remapper (dual-function Space and Caps Lock, see
# bare/kanata/kanata.kbd). On macOS it sends keys through Karabiner's
# DriverKit virtual keyboard. nix-darwin has no kanata module; this follows
# the common community pattern (jtroo/kanata docs/setup-macos.md and
# discussion #1537, chenxin-yan/nix-dotfiles).
#
# One-time manual steps per machine:
#   - approve the driver: System Settings > General > Login Items & Extensions
#     > Driver Extensions > Karabiner-DriverKit-VirtualHIDDevice
#   - grant Input Monitoring and Accessibility to /usr/local/libexec/nix-kanata/kanata
{ lib, pkgs, ... }:
let
  # the driver version kanata is built against (bumps with kanata, e.g. 8.x for 1.13)
  driver = pkgs.kanata.darwinDriver;
  managerApp = "/Applications/.Karabiner-VirtualHIDDevice-Manager.app";
  daemonExe = "${driver}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";

  kanataExe = lib.getExe pkgs.kanata;
  kanata = import ./stable-signed.nix { inherit lib pkgs; } {
    name = "kanata";
    exe = kanataExe;
  };
in
{
  # preActivation: in place before nix-darwin reloads the launchd daemons
  system.activationScripts.preActivation.text = lib.mkAfter ''
    # system extensions only load from /Applications (no symlinks)
    if ! ${lib.getExe' pkgs.diffutils "diff"} -rq "${driver}${managerApp}" "${managerApp}" >/dev/null 2>&1; then
      echo "installing Karabiner VirtualHIDDevice driver ${driver.version}..."
      rm -rf "${managerApp}"
      cp -R "${driver}${managerApp}" "${managerApp}"
      "${managerApp}/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" forceActivate
    fi

    ${kanata.activation}
  '';

  # `command` wraps it in `wait4path /nix/store`, so it can't fail to spawn
  # at boot before the store is mounted
  launchd.daemons.karabiner-vhid-daemon = {
    command = ''"${daemonExe}"'';
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";
    };
  };

  launchd.daemons.kanata.serviceConfig = {
    ProgramArguments = [
      kanata.path
      "--cfg"
      "${../../bare/kanata/kanata.kbd}"
      # don't wait for Enter on errors; launchd restarts it
      "--no-wait"
    ];
    RunAtLoad = true;
    KeepAlive = true;
    ProcessType = "Interactive";
    # errors only: stdout is kanata's info lines plus the driver library's
    # "virtual_hid_keyboard_ready" every few seconds, so it stays at /dev/null
    StandardErrorPath = "/var/log/kanata.log";
    # unused by kanata: changes the plist when the package does, so the
    # daemon restarts onto the newly signed binary
    EnvironmentVariables.KANATA_STORE_PATH = kanataExe;
  };
}
