# Window look and behaviour to match Hyprland under OmniWM.
{
  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";

    # square window corners (rounding = 0); the same global keys OmniWM's
    # "System-wide Window Corners" writes. Apps apply it after a full relaunch.
    CustomUserPreferences.NSGlobalDomain = {
      NSConvolutionOverride1 = 0.01;
      NSConvolutionOverride2 = 0.01;
    };

    # macOS's own tiling would fight OmniWM; the Option accelerator also
    # collides with Option as the OmniWM modifier
    WindowManager = {
      EnableTilingByEdgeDrag = false;
      EnableTopTilingByEdgeDrag = false;
      EnableTilingOptionAccelerator = false;
      EnableTiledWindowMargins = false;
    };
  };
}
