{ pkgs, ... }:

let
  inherit (pkgs) lib stdenvNoCC;

  pname = "torrential";
  version = "0.5.1";

  # where new versions are published: https://github.com/nexxeln/torrential/releases
  # (each asset has a .sha256 next to it)
  sources = {
    x86_64-linux = {
      url = "https://github.com/nexxeln/torrential/releases/download/v${version}/torrential-x86_64-unknown-linux-musl.tar.gz";
      hash = "sha256-PDqQvdbAOaKHe61nEVZewwGt6oiJT3On7rjBC4ZqanQ=";
    };

    aarch64-linux = {
      url = "https://github.com/nexxeln/torrential/releases/download/v${version}/torrential-aarch64-unknown-linux-musl.tar.gz";
      hash = "sha256-DCGgzUFyyCz/nqG0eX+n1+cpIztIzzMR+pyfA8Um9pc=";
    };

    aarch64-darwin = {
      url = "https://github.com/nexxeln/torrential/releases/download/v${version}/torrential-aarch64-apple-darwin.tar.gz";
      hash = "sha256-UzcgeMk6qOlu2zJDcIkFFrGZCk/ZIsFj1q6th07U/2U=";
    };
  };

  system = pkgs.stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl source;

  sourceRoot = ".";
  dontBuild = true;
  # static on Linux, signed on macOS: used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 torrential "$out/bin/torrential"

    runHook postInstall
  '';

  meta = {
    description = "Find films and shows, and watch them on your Mac, phone, or TV while they download";
    homepage = "https://github.com/nexxeln/torrential";
    changelog = "https://github.com/nexxeln/torrential/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "torrential";
  };
}
