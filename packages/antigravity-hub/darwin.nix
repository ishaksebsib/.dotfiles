{
  pkgs,
  version,
  buildId,
}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "antigravity-hub";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/${version}-${buildId}/darwin-arm/Antigravity.dmg";
    hash = "sha256-+dcH42e8X3yHYn3voSXc/6vIGwO0hEvDYdqeSCHomtA=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ pkgs._7zz ];
  # signed bundle, used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R Antigravity.app $out/Applications
    runHook postInstall
  '';

  meta = {
    description = "Desktop environment for managing multiple autonomous agents across independent projects";
    homepage = "https://antigravity.google";
    changelog = "https://antigravity.google/changelog";
    license = pkgs.lib.licenses.unfree;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ pkgs.lib.sourceTypes.binaryNativeCode ];
  };
}
