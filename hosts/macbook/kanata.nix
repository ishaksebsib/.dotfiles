# Kanata keyboard remapper (dual-function Space and Caps Lock, see
# bare/kanata/kanata.kbd). On macOS it sends keys through Karabiner's
# DriverKit virtual keyboard. nix-darwin has no kanata module; this follows
# the common community pattern (jtroo/kanata docs/setup-macos.md and
# discussion #1537, chenxin-yan/nix-dotfiles).
#
# One-time manual steps per machine:
#   - approve the driver: System Settings > General > Login Items & Extensions
#     > Driver Extensions > Karabiner-DriverKit-VirtualHIDDevice
#   - grant Input Monitoring and Accessibility to ${stableKanata}
{ lib, pkgs, ... }:
let
  # the driver version kanata is built against (bumps with kanata, e.g. 8.x for 1.13)
  driver = pkgs.kanata.darwinDriver;
  managerApp = "/Applications/.Karabiner-VirtualHIDDevice-Manager.app";
  daemonExe = "${driver}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";

  # macOS pins Input Monitoring/Accessibility (and background-item approval)
  # to the code signature. Nix's ad-hoc signature is the binary's hash, which
  # changes on every update, so kanata runs from a fixed path, re-signed with
  # a self-signed key kept on this machine: the grants then survive updates.
  kanataExe = lib.getExe pkgs.kanata;
  stableKanata = "/usr/local/libexec/nix-kanata/kanata";
  signingDir = "/var/db/nix-kanata";
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

    if [ ! -s ${signingDir}/key.pem ]; then
      install -d -m 0700 ${signingDir}
      # code signing rejects certificates without digitalSignature/codeSigning
      ${lib.getExe pkgs.openssl} req -x509 -newkey rsa:2048 -nodes -days 36500 \
        -subj "/CN=nix-kanata-codesign" \
        -addext "keyUsage=critical,digitalSignature" \
        -addext "extendedKeyUsage=critical,codeSigning" \
        -keyout ${signingDir}/key.pem -out ${signingDir}/cert.pem 2>/dev/null
      chmod 0600 ${signingDir}/key.pem
    fi
    if [ "$(cat ${signingDir}/signed-from 2>/dev/null)" != "${kanataExe}" ] || [ ! -x ${stableKanata} ]; then
      echo "signing kanata into ${stableKanata}..."
      mkdir -p "$(dirname ${stableKanata})"
      install -m 0755 ${kanataExe} ${stableKanata}.new
      out=$(${lib.getExe pkgs.rcodesign} sign --timestamp-url none \
        --pem-file ${signingDir}/key.pem --pem-file ${signingDir}/cert.pem \
        --binary-identifier org.nixos.kanata ${stableKanata}.new 2>&1) \
        || { echo "$out" >&2; exit 1; }
      mv -f ${stableKanata}.new ${stableKanata}
      echo "${kanataExe}" > ${signingDir}/signed-from
    fi
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
      stableKanata
      "--cfg"
      "${../../bare/kanata/kanata.kbd}"
      # don't wait for Enter on errors; launchd restarts it
      "--no-wait"
    ];
    RunAtLoad = true;
    KeepAlive = true;
    ProcessType = "Interactive";
    StandardOutPath = "/var/log/kanata.log";
    StandardErrorPath = "/var/log/kanata.log";
    # unused by kanata: changes the plist when the package does, so the
    # daemon restarts onto the newly signed binary
    EnvironmentVariables.KANATA_STORE_PATH = kanataExe;
  };
}
