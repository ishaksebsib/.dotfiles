{ hostName, ... }:
{
  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  services.tailscale = {
    openFirewall = true;
    useRoutingFeatures = "client";
  };
}
