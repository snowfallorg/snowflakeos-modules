{ options, config, lib, pkgs, inputs, system, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.snowflakeos;
in
{
  imports = [
    ./gnome.nix
    ./graphical.nix
    ./hardware.nix
    ./version.nix
  ];

  options.modules.snowflakeos = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable SnowflakeOS system default";
    };
  };
  config = mkIf cfg.enable {
    snowflakeos.osInfo.enable = mkDefault true;
    snowflakeos.gnome.enable = mkDefault true;

    environment.systemPackages = with inputs; [
      nix-software-center.packages.${system}.nix-software-center
      nixos-conf-editor.packages.${system}.nixos-conf-editor
      # snowflakeos-module-manager.packages.${system}.snowflakeos-module-manager
      snow.packages.${system}.snow
      pkgs.git # For rebuiling with github flakes
    ];

    # Reasonable Defaults
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = [ "https://snowflakeos.cachix.org/" ];
        trusted-public-keys = [
          "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70="
        ];
      } // (lib.mapAttrsRecursive (_: lib.mkDefault) {
        connect-timeout = 5;
        log-lines = 25;
        min-free = 128000000;
        max-free = 1000000000;
        fallback = true;
        warn-dirty = false;
        auto-optimise-store = true;
      });
    } // (lib.mapAttrsRecursive (_: lib.mkDefault) {
      linkInputs = true;
      generateNixPathFromInputs = true;
      generateRegistryFromInputs = true;
    });
  };
}
