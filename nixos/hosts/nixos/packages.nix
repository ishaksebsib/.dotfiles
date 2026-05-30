{ config, pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    vscode
    git

    # System tools
    curl
    wget
    tlp
    auto-cpufreq
    brightnessctl
    bluez
    blueman
  ];
}
