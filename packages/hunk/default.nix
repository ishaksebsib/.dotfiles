{ pkgs, ... }:

let
  inherit (pkgs) lib stdenvNoCC;

  pname = "hunk";
  version = "0.17.2";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/hunkdiff/-/hunkdiff-${version}.tgz";
    hash = "sha256-xoLDXtb3PEw08S+IjP369Dt/Y/10gJ3OwMIg6ZOXIS4=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/lib/${pname}" "$out/bin"
    cp -r ./* "$out/lib/${pname}/"

    makeWrapper "${pkgs.bun}/bin/bun" "$out/bin/hunk" \
      --add-flags "$out/lib/${pname}/dist/npm/main.js"

    runHook postInstall
  '';

  meta = {
    description = "Review-first terminal diff viewer for agent-authored changesets";
    homepage = "https://github.com/modem-dev/hunk";
    changelog = "https://github.com/modem-dev/hunk/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
    mainProgram = "hunk";
  };
}
