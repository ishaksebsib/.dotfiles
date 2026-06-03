{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;

  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  services.xserver.xkb.layout = "us";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Intel VA-API video acceleration reduces CPU usage in Chrome/video playback.
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";
  };
}
