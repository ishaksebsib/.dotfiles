{ pkgs, ... }:

let
  inherit (pkgs) lib stdenvNoCC;

  pname = "herdr-core";
  version = "0.1.17";

  # where new versions are published: https://releases.herdr.dev/core/latest.json
  sources = {
    x86_64-linux = {
      url = "https://releases.herdr.dev/core/${version}/herdr-core-linux-x86_64.tar.gz";
      hash = "sha256-guxEBD9olL/bcWuXm4fNpD/X+kawEE57e9k+ZNGpuHc=";
    };

    aarch64-linux = {
      url = "https://releases.herdr.dev/core/${version}/herdr-core-linux-aarch64.tar.gz";
      hash = "sha256-OjekVOxjSUz0MG2yZIH+nblmc9iIcjcB0k+KmSroq4w=";
    };

    aarch64-darwin = {
      url = "https://releases.herdr.dev/core/${version}/herdr-core-macos-aarch64.tar.gz";
      hash = "sha256-ztvU1Nm6E4VYgZjdTTxn0mVEePM63VtkRdTQ652l/PM=";
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
  # static on Linux, Developer ID signed on macOS: used as shipped
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 herdr-core "$out/bin/herdr-core"
    # `hc` is the name the docs and the app use
    ln -s herdr-core "$out/bin/hc"

    runHook postInstall
  '';

  meta = {
    description = "Terminals for coding agents that keep running (`hc`)";
    homepage = "https://github.com/herdrdev/herdr-core";
    license = lib.licenses.asl20;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "hc";
  };
}
