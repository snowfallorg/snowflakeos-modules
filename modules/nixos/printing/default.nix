{ config, lib, ... }:
with lib;
{
  config = {
    services.printing.enable = mkDefault true;
  };
}
