{ pkgs, ... }:

let
  inherit (pkgs) lib;

  pname = "paper";
  version = "0.5.15";

  # prebuilt .deb from https://paper.design/downloads
  # NOTE: these URLs always serve the latest release, so bump version + hashes on update
  sources = {
    x86_64-linux = {
      url = "https://download.paper.design/linux/deb/x64";
      hash = "sha256-wl6r++HnzDWG89bxIpGuQdtSo7EigNKcycUC5jdBshU=";
    };

    aarch64-linux = {
      url = "https://download.paper.design/linux/deb/arm64";
      hash = "sha256-+DPqmizqDXTiamWqzJ4s3wwAnHoAnjxn5hrM2nEAOE0=";
    };
  };

  system = pkgs.stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");

  runtimeLibs = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libgbm
    libGL
    libnotify
    libpulseaudio
    libsecret
    libuuid
    libxkbcommon
    nspr
    nss
    pango
    systemd
    vulkan-loader
    wayland
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxscrnsaver
    libxtst
    libxcb
    libxshmfence
  ];
in
pkgs.stdenv.mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl (source // { name = "paper-desktop-${version}-${system}.deb"; });

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = runtimeLibs;

  unpackPhase = ''
    runHook preUnpack
    # extract without the setuid bit on chrome-sandbox, which the nix sandbox rejects
    dpkg-deb --fsys-tarfile "$src" | tar -x --no-same-owner --no-same-permissions
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin" "$out/lib"
    cp -r opt/Paper "$out/lib/paper"
    cp -r usr/share "$out/"

    # setuid sandbox helper can't work from the nix store; chromium falls back to user namespaces
    rm -f "$out/lib/paper/chrome-sandbox"

    makeWrapper "$out/lib/paper/paper-desktop" "$out/bin/paper-desktop" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibs}" \
      --prefix PATH : "${lib.makeBinPath [ pkgs.xdg-utils ]}" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

    # bundled paper cli
    ln -s "$out/lib/paper/resources/app.asar.unpacked/dist/cli-bin/linux-${
      if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "x64"
    }/paper" "$out/bin/paper"

    # upstream entry points at /opt/Paper with a sandbox probe; use our wrapper instead
    substituteInPlace "$out/share/applications/paper-desktop.desktop" \
      --replace-fail "Exec=/bin/sh -c '/opt/Paper/paper-desktop \$(unshare -Ur true 2>/dev/null || echo --no-sandbox) \"\$@\"' _ %U" \
        "Exec=paper-desktop %U"

    runHook postInstall
  '';

  meta = {
    description = "Design tool with a fully connected canvas";
    homepage = "https://paper.design";
    license = lib.licenses.unfree;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "paper-desktop";
  };
}
