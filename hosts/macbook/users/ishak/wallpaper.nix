# Same wallpaper as the NixOS desktop (hyprpaper).
{ lib, ... }:
let
  wallpaper = ../../../../assets/fingerprint.png;
in
{
  home.activation.wallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run /usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to "${wallpaper}"'
  '';
}
