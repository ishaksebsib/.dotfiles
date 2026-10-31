{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  home.packages = with pkgs; [
    telegram-desktop
    google-chrome
    # the Mac builds ship real .app bundles
    (if isDarwin then vlc-bin else vlc)
    (if isDarwin then transmission_4-mac else transmission_4-gtk)
  ];
}
