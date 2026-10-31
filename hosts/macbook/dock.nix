{ config, ... }:
{
  system.defaults.dock = {
    persistent-apps = [
      "${config.system.primaryUserHome}/Applications/Home Manager Apps/Ghostty.app"
    ];
    persistent-others = [ ];
    show-recents = false;
    autohide = true;
  };
}
