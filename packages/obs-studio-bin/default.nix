{ pkgs, ... }:
let
  inherit (pkgs) lib;
  version = "32.2.2";
in
# nixpkgs' obs-studio is Linux-only; this is the official macOS build
pkgs.stdenvNoCC.mkDerivation {
  pname = "obs-studio-bin";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/obsproject/obs-studio/releases/download/${version}/OBS-Studio-${version}-macOS-Apple.dmg";
    hash = "sha256-kg1vJnA9LfbkCFvTwcvtMEiDJQhBNsem6eNwIfvWqvc=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ pkgs._7zz ];
  # signed bundle, used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "OBS Studio ${version} (Apple)/OBS.app" $out/Applications
    runHook postInstall
  '';

  meta = {
    description = "Free and open source software for video recording and live streaming";
    homepage = "https://obsproject.com";
    changelog = "https://github.com/obsproject/obs-studio/releases/tag/${version}";
    license = lib.licenses.gpl2Plus;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
