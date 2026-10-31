{ pkgs, ... }:
let
  inherit (pkgs) lib stdenvNoCC;
  pname = "rex";
  version = "0.1.0";
  build = "1696";
in
# new builds are listed in https://blob.superlogical.com/public/rex-app/preview/appcast.xml
stdenvNoCC.mkDerivation {
  inherit pname;
  version = "${version}-${build}";

  src = pkgs.fetchurl {
    url = "https://blob.superlogical.com/public/rex-app/preview/Rex-${version}-${build}.dmg";
    hash = "sha256-sZIRbP6T/I+c8jtKsLd60DfJUqK92aTs/xiC20Jrv48=";
  };

  sourceRoot = ".";
  nativeBuildInputs = [ pkgs._7zz ];
  # signed bundle, used as shipped (fixup would patch it and trips on Sparkle's dangling symlink)
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R */"Rex Beta.app" $out/Applications
    runHook postInstall
  '';

  meta = {
    description = "Rex app by Superlogical (preview builds)";
    license = lib.licenses.unfree;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
