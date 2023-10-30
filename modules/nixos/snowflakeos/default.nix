{ options, config, lib, pkgs, inputs, system, ... }:

with lib;
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
    nixSoftwareCenter.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable Nix Software Center, a graphical software center for Nix";
    };
    nixosConfEditor.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable NixOS Configuration Editor, a graphical editor for NixOS configurations";
    };
    snowflakeosModuleManager.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable SnowflakeOS Module Manager, a graphical tool for managing SnowflakeOS modules";
    };
    binaryCompat.enable = mkOption {
      type = bool;
      default = false;
      description = "Enables FHS binary compatibility (may not work in all cases)";
    };
  };
  config = mkMerge [
    (mkIf cfg.nixSoftwareCenter.enable {
      environment.systemPackages = with inputs; [
        nix-software-center.packages.${system}.nix-software-center
      ];
    })
    (mkIf cfg.nixosConfEditor.enable {
      environment.systemPackages = with inputs; [
        nixos-conf-editor.packages.${system}.nixos-conf-editor
      ];
    })
    (mkIf cfg.snowflakeosModuleManager.enable {
      environment.systemPackages = with inputs; [
        snowflakeos-module-manager.packages.${system}.snowflakeos-module-manager
      ];
    })
    (mkIf cfg.binaryCompat.enable {
      programs.nix-ld = {
        enable = mkDefault true;
        libraries = with pkgs; [
          acl
          attr
          bzip2
          curl
          libglvnd
          libsodium
          libssh
          libxml2
          mesa
          openssl
          stdenv.cc.cc
          systemd
          util-linux
          vulkan-loader
          xz
          zlib
          zstd
        ];
      };
      services.envfs.enable = mkDefault true;
    })
    ({
      snowflakeos.osInfo.enable = mkDefault true;
      snowflakeos.gnome.enable = mkDefault true;

      environment.systemPackages = with inputs; [
        snow.packages.${system}.snow
        pkgs.git # For rebuiling with github flakes
      ];

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      programs.mtr.enable = mkDefault true;
      programs.gnupg.agent = {
        enable = mkDefault true;
        enableSSHSupport = mkDefault true;
      };

      # Reasonable Defaults
      nix =
        {
          settings = {
            experimental-features = [ "nix-command" "flakes" ];
            substituters = [ "https://snowflakeos.cachix.org/" ];
            trusted-public-keys = [
              "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70="
            ];
          } // (mapAttrsRecursive (_: mkDefault) {
            connect-timeout = 5;
            log-lines = 25;
            min-free = 128000000;
            max-free = 1000000000;
            fallback = true;
            warn-dirty = false;
            auto-optimise-store = true;
          });
        } // (mapAttrsRecursive (_: mkDefault) {
        linkInputs = true;
        generateNixPathFromInputs = true;
        generateRegistryFromInputs = true;
      });
    })
  ];
}
