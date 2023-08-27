{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.biosboot;
in
{
  options.modules.biosboot = with types; {
    device = mkOption {
      type = str;
      default = "nodev";
      description = "device";
    };
    cleantmp = mkOption {
      type = bool;
      default = true;
      description = "Clean /tmp on boot.";
    };
  };

  config = {
    boot.loader = {
      systemd-boot.enable = false;
      grub.enable = true;
      grub.useOSProber = true;
      grub.device = cfg.device;
    };
    boot.tmp.cleanOnBoot = cfg.cleantmp;
  };
}
