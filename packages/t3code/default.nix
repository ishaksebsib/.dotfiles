{ pkgs, ... }:

let
  inherit (pkgs) lib;

  pname = "t3code";
  version = "0.1.2";

  # prebuilt .deb from https://github.com/pingdotgg/t3code/releases
  sources = {
    x86_64-linux = {
      url = "https://github.com/pingdotgg/t3code/releases/download/v${version}/T3-Code-${version}-amd64.deb";
      hash = "sha256-1Hg2377xQEinv6Mg1tr8F1NCVEJ5COWnJYjuviCDf1M=";
    };

    aarch64-linux = {
      url = "https://github.com/pingdotgg/t3code/releases/download/v${version}/T3-Code-${version}-arm64.deb";
      hash = "sha256-TB8Gp4NIqBeimzHuqr0b2leYWGax6R5QJYuvH3LQOOE=";
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
    pipewire
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

  unwrapped = pkgs.stdenv.mkDerivation {
    inherit pname version;

    src = pkgs.fetchurl source;

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
      cp -r "opt/T3 Code (Beta)" "$out/lib/t3code"
      cp -r usr/share "$out/"

      # setuid sandbox helper can't work from the nix store; chromium falls back to user namespaces
      rm -f "$out/lib/t3code/chrome-sandbox"
      # musl builds of native modules are never loaded on glibc and can't be patched
      rm -rf "$out"/lib/t3code/resources/app.asar.unpacked/node_modules/@*/*-musl

      makeWrapper "$out/lib/t3code/t3code" "$out/bin/t3code" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibs}" \
        --prefix PATH : "${lib.makeBinPath [ pkgs.xdg-utils ]}" \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

      substituteInPlace "$out/share/applications/t3code.desktop" \
        --replace-fail 'Exec="/opt/T3 Code (Beta)/t3code" %U' "Exec=t3code %U"

      runHook postInstall
    '';

    meta = {
      description = "Desktop app for coding agents";
      homepage = "https://t3.codes";
      changelog = "https://github.com/pingdotgg/t3code/releases/tag/v${version}";
      license = lib.licenses.mit;
      platforms = builtins.attrNames sources;
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
      mainProgram = "t3code";
    };
  };
in
# run inside an FHS env so binaries the app downloads or spawns at runtime
# find a standard /lib64 loader and glibc
pkgs.buildFHSEnv {
  inherit pname version;

  targetPkgs = _: [ unwrapped ];

  runScript = "${unwrapped}/bin/t3code";

  extraInstallCommands = ''
    mkdir -p "$out/share"
    cp -r ${unwrapped}/share/applications ${unwrapped}/share/icons "$out/share/"
  '';

  passthru = { inherit unwrapped; };

  inherit (unwrapped) meta;
}
