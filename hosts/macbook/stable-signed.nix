# Not a module: a helper imported by kanata.nix and skhd.nix.
#
# Installs a Nix-built binary at a fixed path, re-signed with a self-signed key
# kept on this machine. macOS pins privacy grants (Input Monitoring,
# Accessibility) and background-item approval to a binary's code signature;
# Nix's ad-hoc signature is the binary's hash, which changes on every update.
# Signed with a stable key, the requirement becomes `identifier "org.nixos.<name>"
# and certificate root = H"…"`, so a grant survives updates. The key stays out
# of the world-readable /nix/store.
{ lib, pkgs }:
let
  signingDir = "/var/db/nix-codesign";
in
{ name, exe }:
let
  path = "/usr/local/libexec/nix-${name}/${name}";
in
{
  inherit path;

  # for system.activationScripts.preActivation (runs as root, before launchd
  # reloads the daemons and agents that use `path`)
  activation = ''
    # the key started out in /var/db/nix-kanata; moving it keeps existing grants valid
    if [ -d /var/db/nix-kanata ] && [ ! -e ${signingDir} ]; then
      mv /var/db/nix-kanata ${signingDir}
      rm -f ${signingDir}/signed-from
    fi
    if [ ! -s ${signingDir}/key.pem ]; then
      install -d -m 0700 ${signingDir}
      # code signing rejects certificates without digitalSignature/codeSigning
      ${lib.getExe pkgs.openssl} req -x509 -newkey rsa:2048 -nodes -days 36500 \
        -subj "/CN=nix-codesign" \
        -addext "keyUsage=critical,digitalSignature" \
        -addext "extendedKeyUsage=critical,codeSigning" \
        -keyout ${signingDir}/key.pem -out ${signingDir}/cert.pem 2>/dev/null
      chmod 0600 ${signingDir}/key.pem
    fi
    if [ "$(cat ${signingDir}/signed-from-${name} 2>/dev/null)" != "${exe}" ] || [ ! -x ${path} ]; then
      echo "signing ${name} into ${path}..."
      mkdir -p "$(dirname ${path})"
      install -m 0755 ${exe} ${path}.new
      out=$(${lib.getExe pkgs.rcodesign} sign --timestamp-url none \
        --pem-file ${signingDir}/key.pem --pem-file ${signingDir}/cert.pem \
        --binary-identifier org.nixos.${name} ${path}.new 2>&1) \
        || { echo "$out" >&2; exit 1; }
      mv -f ${path}.new ${path}
      echo "${exe}" > ${signingDir}/signed-from-${name}
    fi
  '';
}
