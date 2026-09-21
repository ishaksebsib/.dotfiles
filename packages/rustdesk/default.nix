{ pkgs, ... }:

let
  inherit (pkgs) lib appimageTools;

  pname = "rustdesk";
  version = "1.4.9";

  sources = {
    x86_64-linux = {
      url = "https://github.com/rustdesk/rustdesk/releases/download/${version}/rustdesk-${version}-x86_64.AppImage";
      hash = "sha256-eQLNYKTymBfuviZooVyaGVKsaQ6Pewe/52IP7dTighc=";
    };

    aarch64-linux = {
      url = "https://github.com/rustdesk/rustdesk/releases/download/${version}/rustdesk-${version}-aarch64.AppImage";
      hash = "sha256-qVWhANnIPscmWhTtdM+ENo/OcPqfOUOzmW2rBVmcyEQ=";
    };
  };

  system = pkgs.stdenv.hostPlatform.system;
  source = sources.${system} or (throw "${pname}: unsupported system ${system}");

  src = pkgs.fetchurl source;

  # Used only to lift the desktop entry and icon out of the AppImage.
  contents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  # The AppImage bundles its own libraries, but screen capture and audio have to
  # talk to the host's PipeWire/portal stack, so those come from outside.
  extraPkgs =
    pkgs: with pkgs; [
      pipewire
      libpulseaudio
      libva
      xdg-desktop-portal
      xdg-user-dirs
      xdotool
      libayatana-appindicator
    ];

  extraInstallCommands = ''
    install -Dm444 ${contents}/rustdesk.desktop -t $out/share/applications
    install -Dm444 ${contents}/rustdesk.svg -t $out/share/icons/hicolor/scalable/apps

    substituteInPlace $out/share/applications/rustdesk.desktop \
      --replace-fail 'Exec=usr/share/rustdesk/rustdesk' 'Exec=${pname} %u' \
      --replace-fail 'Name=rustdesk' 'Name=RustDesk'
  '';

  meta = {
    description = "Open source remote desktop, official prebuilt AppImage";
    homepage = "https://rustdesk.com";
    changelog = "https://github.com/rustdesk/rustdesk/releases/tag/${version}";
    license = lib.licenses.agpl3Plus;
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "rustdesk";
  };
}
