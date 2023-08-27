{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.pipewire;
in
{
  options.modules.pipewire = with types; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Pipewire audio";
    };
    jack = 
      lib.mkEnableOption "Enable Jack support";
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      jack.enable = cfg.jack;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
