{ pkgs, ... }:

let
  inherit (pkgs) lib;

  pname = "claude-desktop";
  version = "2.42304.2";

  # prebuilt .deb from Anthropic's apt repo:
  # https://downloads.claude.ai/claude-desktop/apt/stable/dists/stable/main/binary-<arch>/Packages
  sources = {
    x86_64-linux = {
      url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_${version}_amd64.deb";
      hash = "sha256-OKfVi1ipdsiMplLqovesAsh8SjiK4w9GjXK3kOa1f5A=";
    };

    aarch64-linux = {
      url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_${version}_arm64.deb";
      hash = "sha256-APuFZMoVYIaxHTLwa7mld07xCE9GMtAV9kjcJbf+Prs=";
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
    libcap_ng
    libdrm
    libgbm
    libGL
    libnotify
    libpulseaudio
    libsecret
    libseccomp
    libuuid
    libxkbcommon
    libayatana-appindicator
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
      cp -r usr/lib/claude-desktop "$out/lib/"
      cp -r usr/share "$out/"

      # setuid sandbox helper can't work from the nix store; chromium falls back to user namespaces
      rm -f "$out/lib/claude-desktop/chrome-sandbox"

      makeWrapper "$out/lib/claude-desktop/claude-desktop" "$out/bin/claude-desktop" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibs}" \
        --prefix PATH : "${lib.makeBinPath [ pkgs.xdg-utils ]}" \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

      runHook postInstall
    '';

    meta = {
      description = "Claude desktop app (Chat, Cowork and Claude Code)";
      homepage = "https://code.claude.com/docs/en/desktop-linux";
      license = lib.licenses.unfree;
      platforms = builtins.attrNames sources;
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
      mainProgram = "claude-desktop";
    };
  };
in
# run inside an FHS env so binaries the app downloads at runtime (the Claude Code
# engine in ~/.config/Claude/claude-code) find a standard /lib64 loader and glibc
pkgs.buildFHSEnv {
  inherit pname version;

  targetPkgs = _: [ unwrapped ];

  runScript = "${unwrapped}/bin/claude-desktop";

  extraInstallCommands = ''
    mkdir -p "$out/share"
    cp -r ${unwrapped}/share/applications ${unwrapped}/share/icons "$out/share/"
  '';

  passthru = { inherit unwrapped; };

  inherit (unwrapped) meta;
}
