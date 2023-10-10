{ lib, config, options, pkgs, ... }:

with lib;
{
  options.snowflakeos.graphical = {
    enable = mkEnableOption "SnowflakeOS default graphical configurations (not including DE)";
  };

  config = mkIf config.snowflakeos.graphical.enable {
    # Enable fwupd
    services.fwupd.enable = mkDefault true;

    # Add opengl/vulkan support
    hardware.opengl = {
      enable = mkDefault true;
      driSupport = mkDefault config.hardware.opengl.enable;
      driSupport32Bit = mkDefault (config.hardware.opengl.enable && pkgs.stdenv.hostPlatform.isx86);
    };
  };
}
