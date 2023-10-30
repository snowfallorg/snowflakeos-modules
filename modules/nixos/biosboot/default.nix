{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.biosboot;
in
{
  config = {
    boot.loader = {
      systemd-boot.enable = false;
      grub.enable = true;
      grub.useOSProber = true;
    };
    boot.tmp.cleanOnBoot = mkDefault true;
  };
}
