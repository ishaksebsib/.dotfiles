{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Compressed RAM swap: prevents hard freezes when RAM is exhausted.
  # This is virtual capacity; it only uses real RAM as pages are compressed.
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    priority = 100;
    algorithm = "zstd";
  };

  # Tune the VM for zram responsiveness.
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.page-cluster" = 0;
  };
}
