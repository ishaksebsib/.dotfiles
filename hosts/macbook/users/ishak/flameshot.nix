# Region screenshots to the clipboard, like hyprshot on NixOS; the
# keys are in bare/skhd/skhdrc. No daemon or tray icon: skhd starts
# `flameshot gui` per capture, so the Screen Recording grant goes to skhd.
{ pkgs, ... }:
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
  '';
}
