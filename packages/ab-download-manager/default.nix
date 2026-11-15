{ pkgs, ... }:

let
  inherit (pkgs) lib stdenv;

  pname = "ab-download-manager";
  version = "1.11.4";

  # where new versions are published: https://github.com/amir1376/ab-download-manager/releases
  # macOS uses the .dmg: the mac .tar.gz breaks the bundle's signature
  sources = {
    x86_64-linux = {
      url = "https://github.com/amir1376/ab-download-manager/releases/download/v${version}/ABDownloadManager_${version}_linux_x64.tar.gz";
      hash = "sha256-M8SzNHJRjB8Lgpw4jvEU+DY4BUk7jGfh54aI9YDvp0E=";
    };

    aarch64-linux = {
      url = "https://github.com/amir1376/ab-download-manager/releases/download/v${version}/ABDownloadManager_${version}_linux_arm64.tar.gz";
      hash = "sha256-zjDA4tinI7RlHpgN7w8ZqDipOaf89VxGV+kzvXvKR4s=";
    };

    aarch64-darwin = {
      url = "https://github.com/amir1376/ab-download-manager/releases/download/v${version}/ABDownloadManager_${version}_mac_arm64.dmg";
      hash = "sha256-nBwpVeL2JBhEG9ZisdEE4KGzh3XdESMrs3vpLq0klV0=";
    };
  };

  system = stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");

  desktopItem = pkgs.makeDesktopItem {
    name = pname;
    desktopName = "AB Download Manager";
    comment = "Download manager that speeds up your downloads";
    exec = pname;
    icon = pname;
    categories = [
      "Network"
      "FileTransfer"
    ];
    startupWMClass = "ABDownloadManager";
  };
in
stdenv.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl source;

  sourceRoot = ".";
  dontBuild = true;
  # signed bundle, used as shipped
  dontFixup = stdenv.hostPlatform.isDarwin;

  nativeBuildInputs =
    if stdenv.hostPlatform.isDarwin then [ pkgs._7zz ] else [ pkgs.autoPatchelfHook ];

  # a jpackage app with its own Java runtime
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux (
    with pkgs;
    [
      stdenv.cc.cc.lib
      alsa-lib
      fontconfig
      freetype
      libGL
      libx11
      libxext
      libxi
      libxrender
      libxtst
      libxkbcommon
      wayland
      zlib
    ]
  );

  # dlopen'd by the Compose UI (OpenGL) and for native dialogs
  runtimeDependencies = lib.optionals stdenv.hostPlatform.isLinux [
    pkgs.libGL
    pkgs.gtk3
  ];

  # -snld keeps the bundle's symlinks, which its signature covers
  unpackCmd = lib.optionalString stdenv.hostPlatform.isDarwin ''
    7zz x -snld "$curSrc"
  '';

  installPhase =
    if stdenv.hostPlatform.isDarwin then
      ''
        runHook preInstall
        mkdir -p "$out/Applications"
        cp -R ABDownloadManager/ABDownloadManager.app "$out/Applications/"
        runHook postInstall
      ''
    else
      ''
        runHook preInstall
        mkdir -p "$out/lib" "$out/bin"
        cp -r ABDownloadManager "$out/lib/ab-download-manager"
        ln -s "$out/lib/ab-download-manager/bin/ABDownloadManager" "$out/bin/ab-download-manager"
        install -Dm644 ABDownloadManager/lib/ABDownloadManager.png \
          "$out/share/icons/hicolor/512x512/apps/ab-download-manager.png"
        install -Dm644 ${desktopItem}/share/applications/ab-download-manager.desktop -t "$out/share/applications"
        runHook postInstall
      '';

  meta = {
    description = "Download manager that speeds up your downloads";
    homepage = "https://abdownloadmanager.com";
    changelog = "https://github.com/amir1376/ab-download-manager/releases/tag/v${version}";
    license = lib.licenses.asl20;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "ab-download-manager";
  };
}
