# Region screenshots to the clipboard, run per capture (no daemon or tray
# icon). Keys: Print / Shift+Print in bare/hypr/hyprland.conf, Option+S /
# Option+Shift+S in bare/skhd/skhdrc. On macOS skhd starts it, so the Screen
# Recording grant goes to skhd.
{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.flameshot ];

  xdg.configFile."flameshot/flameshot.ini".text = ''
    [General]
    disabledTrayIcon=true
    showStartupLaunchMessage=false
    showDesktopNotification=false
    showHelp=false
    showSidePanelButton=false
    ; Catppuccin Macchiato lavender, like the OmniWM border
    uiColor=#b7bdf8
  ''
  # Hyprland has no screenshot portal flameshot can use; it captures via grim
  + lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
    useGrimAdapter=true
    disabledGrimWarning=true
  '';
}
