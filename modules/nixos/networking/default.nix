{ config, lib, ... }:
with lib;
{
  config = {
    networking.networkmanager.enable = mkDefault true;
    networking.wireless.enable = mkDefault false;
  };
}
