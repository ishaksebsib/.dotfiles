{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.steam.enable = true;

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
    # Keep Bluetooth headphones on A2DP (music quality) when an app opens the mic,
    # instead of switching to the choppy HFP headset profile.
    wireplumber.extraConfig."51-bluetooth-no-autoswitch" = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };
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
