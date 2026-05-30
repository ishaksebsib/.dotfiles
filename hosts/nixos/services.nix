{ config, pkgs, ... }:
let
  yaml = pkgs.formats.yaml { };
in
{
  services.auto-cpufreq.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/interception/dual-mods.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_SPACE, KEY_CAPSLOCK]
    '';
  };

  environment.etc."interception/dual-mods.yaml".source = yaml.generate "dual-mods.yaml" {
    TIMING = {
      TAP_MILLISEC = 200;
    };
    MAPPINGS = [
      {
        KEY = "KEY_SPACE";
        TAP = "KEY_SPACE";
        HOLD = "KEY_LEFTMETA";
      }
      {
        KEY = "KEY_CAPSLOCK";
        TAP = "KEY_CAPSLOCK";
        HOLD = "KEY_LEFTCTRL";
      }
    ];
  };
}
