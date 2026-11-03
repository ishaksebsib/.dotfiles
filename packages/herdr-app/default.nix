{ pkgs, ... }:

let
  inherit (pkgs) lib stdenv;

  pname = "herdr-app";
  version = "0.1.12";

  # where new versions are published: https://releases.herdr.dev/app/latest.json
  sources = {
    x86_64-linux = {
      url = "https://releases.herdr.dev/app/${version}/herdr-app-linux-x86_64.tar.gz";
      hash = "sha256-omXmySXEh0WEBnQf+gnS+g09S9QBo07YwBwzYQjlfB8=";
    };

    aarch64-linux = {
      url = "https://releases.herdr.dev/app/${version}/herdr-app-linux-aarch64.tar.gz";
      hash = "sha256-dJ8x0w4/TX4k4nSPdNnLSpvdpMloAnq6/7b7I5/+tpQ=";
    };

    aarch64-darwin = {
      url = "https://releases.herdr.dev/app/${version}/herdr-app-macos-aarch64.tar.gz";
      hash = "sha256-AGpPaECaeVSNGqbF+Z2okRt9FJEO8qxr0aPc5jTKXQM=";
    };
  };

  system = stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");

  desktopItem = pkgs.makeDesktopItem {
    name = pname;
    desktopName = "Herdr";
    comment = "Terminals and coding agents that keep running";
    exec = pname;
    icon = pname;
    categories = [ "Development" ];
    startupWMClass = pname;
  };
in
stdenv.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl source;

  sourceRoot = ".";
  dontBuild = true;
  # signed bundle, used as shipped
  dontFixup = stdenv.hostPlatform.isDarwin;

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [ pkgs.autoPatchelfHook ];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    stdenv.cc.cc.lib
    pkgs.libxcb
    pkgs.libxkbcommon
  ];

  # dlopen'd by the GPU renderer, so autoPatchelf can't see them
  runtimeDependencies = lib.optionals stdenv.hostPlatform.isLinux [
    pkgs.libGL
    pkgs.vulkan-loader
    pkgs.wayland
  ];

  # The icon stays out of the binary's folder: the app treats a folder holding
  # herdr-app.svg as its own install and tries to update itself in place.
  installPhase =
    if stdenv.hostPlatform.isDarwin then
      ''
        runHook preInstall
        mkdir -p "$out/Applications" "$out/bin"
        cp -R Herdr.app "$out/Applications/"
        ln -s "$out/Applications/Herdr.app/Contents/MacOS/Herdr" "$out/bin/herdr-app"
        runHook postInstall
      ''
    else
      ''
        runHook preInstall
        install -Dm755 herdr-app/herdr-app "$out/bin/herdr-app"
        install -Dm644 herdr-app/herdr-app.svg "$out/share/icons/hicolor/scalable/apps/herdr-app.svg"
        install -Dm644 ${desktopItem}/share/applications/herdr-app.desktop -t "$out/share/applications"
        runHook postInstall
      '';

  meta = {
    description = "Desktop app for terminals and coding agents";
    homepage = "https://github.com/herdrdev/herdr-app";
    license = lib.licenses.asl20;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "herdr-app";
  };
}
