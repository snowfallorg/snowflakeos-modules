{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.networking;
in
{
  options.modules.networking = with types; {
    enable = mkOption {
      type = bool;
      default = true;
      description = "Enable networkmanager";
    };
    firewall = mkOption {
      type = bool;
      default = true;
      description = "Enable firewall";
    };
    allowedTCPPorts =
      mkOption {
        type = listOf port;
        default = [ ];
        description = "List of TCP ports to allow";
      };
    allowedUDPPorts =
      mkOption {
        type = listOf port;
        default = [ ];
        description = "List of UDP ports to allow";
      };
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = cfg.enable;
    networking.firewall.enable = cfg.firewall;
    networking.firewall.allowedTCPPorts = cfg.allowedTCPPorts;
    networking.firewall.allowedUDPPorts = cfg.allowedUDPPorts;
  };
}
