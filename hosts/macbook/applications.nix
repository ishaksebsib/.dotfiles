# Apps copied to /Applications instead of ~/Applications: macOS only activates
# system extensions (VPN, virtual camera) from there, and RustDesk's service expects it
{
  lib,
  pkgs,
  perSystem,
  ...
}:
let
  apps = [
    {
      name = "ProtonVPN";
      pkg = pkgs.proton-vpn;
    }
    {
      name = "RustDesk";
      pkg = perSystem.self.rustdesk;
    }
    {
      name = "OBS";
      pkg = perSystem.self.obs-studio-bin;
    }
  ];
  cmp = lib.getExe' pkgs.diffutils "cmp";
  seal = "Contents/_CodeSignature/CodeResources";
  install =
    { name, pkg }:
    let
      src = "${pkg}/Applications/${name}.app";
      dst = "/Applications/${name}.app";
    in
    ''
      if ! ${cmp} -s "${src}/${seal}" "${dst}/${seal}"; then
        echo "installing ${name} ${pkg.version}..."
        rm -rf "${dst}"
        cp -R "${src}" "${dst}"
        # Spotlight doesn't pick up the copy by itself
        /usr/bin/mdimport "${dst}" || true
      fi
    '';
in
{
  system.activationScripts.postActivation.text = lib.mkAfter (lib.concatMapStrings install apps);
}
