{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
    hyprpaper
    hyprshot
    swaynotificationcenter
    playerctl
    brightnessctl
    (pkgs.writeShellScriptBin "polkit-gnome-auth" ''
      exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    '')
  ];

  home.file.".config/hypr".source = ../../../../bare/hypr;
  home.file.".config/imgs".source = ../../../../assets;
}
