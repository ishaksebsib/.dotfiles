{ pkgs, ... }:

let
  pname = "handy";
  version = "0.8.3";

  runtimeLibs = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    cairo
    dbus
    gdk-pixbuf
    glib
    gtk3
    gtk-layer-shell
    libayatana-appindicator
    libsoup_3
    openssl
    pango
    vulkan-loader
    webkitgtk_4_1
  ];
in
pkgs.stdenvNoCC.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl {
    url = "https://github.com/cjpais/Handy/releases/download/v${version}/Handy_${version}_amd64.deb";
    hash = "sha256-obNV5/Vbn8bYHN61ow5E/bTgxJKq1Pt/Aj0hLPbsOjM=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = runtimeLibs;

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x "$src" .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -r usr/* "$out/"

    runHook postInstall
  '';

  postFixup = ''
    for bin in "$out"/bin/*; do
      wrapProgram "$bin" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath runtimeLibs}"
    done
  '';

  meta = {
    description = "Cross-platform desktop automation app";
    homepage = "https://github.com/cjpais/Handy";
    license = pkgs.lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "handy";
  };
}
