{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.efiboot;
in
{
  options.modules.efiboot = with types; {
    bootloader = mkOption {
      type = enum [ "grub" "systemd-boot" ];
      default = "systemd-boot";
      description = "The kernel to use for booting.";
    };
    cleantmp = mkOption {
      type = bool;
      default = true;
      description = "Clean /tmp on boot.";
    };
  };


  config = mkMerge [
    (mkIf (cfg.bootloader == "systemd-boot")
      {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
      })
    (mkIf (cfg.bootloader == "grub") {
      boot.loader.systemd-boot.enable = false;
      boot.loader.grub.enable = true;
      boot.loader.grub.useOSProber = true;
      boot.loader.grub.efiSupport = true;
      boot.loader.grub.device = "nodev";
    })
    { boot.tmp.cleanOnBoot = cfg.cleantmp; }
  ];
}
