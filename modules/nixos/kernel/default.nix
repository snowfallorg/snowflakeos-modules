{ config, lib, pkgs, ... }:
with lib;
{
  config = {
    boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };
}
