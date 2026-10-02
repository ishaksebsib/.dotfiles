{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    # toggle OBS recording over obs-websocket (works without OBS focused on Wayland)
		# NOTE: in order to this to work, you need to enable "WebSocket Server" in OBS
    (writeShellApplication {
      name = "obs-record-toggle";
      runtimeInputs = [ obs-cmd jq ];
      text = ''
        cfg="$HOME/.config/obs-studio/plugin_config/obs-websocket/config.json"
        port=$(jq -r '.server_port' "$cfg")
        pass=$(jq -r '.server_password' "$cfg")
        obs-cmd --websocket "obsws://localhost:$port/$pass" recording toggle
      '';
    })
  ];
}
