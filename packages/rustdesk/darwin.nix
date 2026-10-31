{ pkgs, version }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "rustdesk";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/rustdesk/rustdesk/releases/download/${version}/rustdesk-${version}-aarch64.dmg";
    hash = "sha256-95NVl7JH1CyPKi7XEXap9YaAGM2eGjO4CWQYpmjIyvA=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ pkgs._7zz ];
  # signed bundle, used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R rustdesk-${version}/RustDesk.app $out/Applications
    runHook postInstall
  '';

  meta = {
    description = "Open source remote desktop, official prebuilt DMG";
    homepage = "https://rustdesk.com";
    changelog = "https://github.com/rustdesk/rustdesk/releases/tag/${version}";
    license = pkgs.lib.licenses.agpl3Plus;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ pkgs.lib.sourceTypes.binaryNativeCode ];
  };
}
