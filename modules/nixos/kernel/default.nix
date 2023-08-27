{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.kernel;
in
{
  options.modules.kernel = with types; {
    package = mkOption {
      type = types.raw;
      default = pkgs.linuxPackages_latest;
      description = "The kernel to use for booting.";
    };
  };

  config = {
    boot.kernelPackages = cfg.package;
  };
}
