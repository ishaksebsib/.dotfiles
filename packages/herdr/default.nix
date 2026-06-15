{ pkgs, ... }:

let
  inherit (pkgs) lib stdenvNoCC;

  pname = "herdr";
  version = "0.6.10";

  sources = {
    x86_64-linux = {
      url = "https://github.com/ogulcancelik/herdr/releases/download/v${version}/herdr-linux-x86_64";
      hash = "sha256-eNKY1aHvB2tGB+jjyS2Y9d6fDLMNrzGqkQoabpq7T6E=";
    };

    aarch64-linux = {
      url = "https://github.com/ogulcancelik/herdr/releases/download/v${version}/herdr-linux-aarch64";
      hash = "sha256-sxRKQd82TwVBu73+hA+mHb1n2vbjE+4xf+SV0sz0kno=";
    };
  };

  system = pkgs.stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl source;

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 "$src" "$out/bin/herdr"

    runHook postInstall
  '';

  meta = {
    description = "Agent multiplexer that lives in your terminal";
    homepage = "https://github.com/ogulcancelik/herdr";
    changelog = "https://github.com/ogulcancelik/herdr/releases/tag/v${version}";
    license = lib.licenses.agpl3Plus;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "herdr";
  };
}
