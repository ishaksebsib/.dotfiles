{ pkgs, version }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "handy";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/cjpais/Handy/releases/download/v${version}/Handy_${version}_aarch64.dmg";
    hash = "sha256-DLWMJyrvrWcNxVY3DO9y7zuuWsNdf8UTXXxHWFoxj88=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ pkgs._7zz ];
  # signed bundle, used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R Handy/Handy.app $out/Applications
    runHook postInstall
  '';

  meta = {
    description = "Cross-platform desktop automation app";
    homepage = "https://github.com/cjpais/Handy";
    license = pkgs.lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ pkgs.lib.sourceTypes.binaryNativeCode ];
  };
}
