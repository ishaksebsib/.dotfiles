{ pkgs, ... }:

let
  inherit (pkgs) lib;

  pname = "antigravity-hub";
  version = "2.26.0";
  # download URLs embed a build id next to the version; latest is in
  # https://antigravity-hub-auto-updater-974169037036.us-central1.run.app/manifest/latest-x64-linux.yml
  buildId = "6546645232517120";

  # prebuilt .deb from https://antigravity.google/download
  sources = {
    x86_64-linux = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/${version}-${buildId}/linux-x64/Antigravity.deb";
      hash = "sha256-YBmTABFb6ZaKjqnefpu8ic0Xf16e/JFXV9dx+KsONuA=";
    };

    aarch64-linux = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/${version}-${buildId}/linux-arm/Antigravity.deb";
      hash = "sha256-MLnV2DHdYx+mCNqrYjDU7MfRkBmbWTH53SBfnk6FfXE=";
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

    # command, desktop entry and icon are renamed to antigravity-hub so they
    # don't collide with the Antigravity IDE, which also uses "antigravity"
    installPhase = ''
      runHook preInstall

      mkdir -p "$out/bin" "$out/lib" "$out/share/applications" "$out/share/icons/hicolor/512x512/apps"
      cp -r opt/Antigravity "$out/lib/antigravity-hub"

      # setuid sandbox helper can't work from the nix store; chromium falls back to user namespaces
      rm -f "$out/lib/antigravity-hub/chrome-sandbox"

      makeWrapper "$out/lib/antigravity-hub/antigravity" "$out/bin/antigravity-hub" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibs}" \
        --prefix PATH : "${lib.makeBinPath [ pkgs.xdg-utils ]}" \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

      cp usr/share/icons/hicolor/512x512/apps/antigravity.png \
        "$out/share/icons/hicolor/512x512/apps/antigravity-hub.png"

      substitute usr/share/applications/antigravity.desktop "$out/share/applications/antigravity-hub.desktop" \
        --replace-fail "Name=Antigravity" "Name=Antigravity Hub" \
        --replace-fail "Exec=/opt/Antigravity/antigravity %U" "Exec=antigravity-hub %U" \
        --replace-fail "Icon=antigravity" "Icon=antigravity-hub"

      runHook postInstall
    '';

    meta = {
      description = "Desktop environment for managing multiple autonomous agents across independent projects";
      homepage = "https://antigravity.google";
      changelog = "https://antigravity.google/changelog";
      license = lib.licenses.unfree;
      platforms = builtins.attrNames sources;
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
      mainProgram = "antigravity-hub";
    };
  };
in
# run inside an FHS env so binaries the app downloads or spawns at runtime
# find a standard /lib64 loader and glibc
pkgs.buildFHSEnv {
  inherit pname version;

  targetPkgs = _: [ unwrapped ];

  runScript = "${unwrapped}/bin/antigravity-hub";

  extraInstallCommands = ''
    mkdir -p "$out/share"
    cp -r ${unwrapped}/share/applications ${unwrapped}/share/icons "$out/share/"
  '';

  passthru = { inherit unwrapped; };

  inherit (unwrapped) meta;
}
