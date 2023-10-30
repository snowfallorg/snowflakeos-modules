{ config, lib, pkgs, ... }:
with lib;
{
  config = {
    networking.networkmanager.enable = mkDefault true;
    networking.wireless.enable = mkDefault false;
    # Workaround for https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online = {
      serviceConfig = {
        ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
      };
    };
  };
}
