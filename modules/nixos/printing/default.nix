{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.printing;
in
{
  options.modules.printing = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable CUPS to print documents.";
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
  };
}
