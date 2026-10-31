{ pkgs, version }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "t3code";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/pingdotgg/t3code/releases/download/v${version}/T3-Code-${version}-arm64.dmg";
    hash = "sha256-e7QPln8iAHKFuMe8DIS9NmDuSk7ZatcfLoiHUOUnU5Y=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ pkgs._7zz ];
  # signed bundle, used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "T3 Code (Beta) ${version} Installer/T3 Code (Beta).app" $out/Applications
    runHook postInstall
  '';

  meta = {
    description = "Desktop app for coding agents";
    homepage = "https://t3.codes";
    changelog = "https://github.com/pingdotgg/t3code/releases/tag/v${version}";
    license = pkgs.lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ pkgs.lib.sourceTypes.binaryNativeCode ];
  };
}
