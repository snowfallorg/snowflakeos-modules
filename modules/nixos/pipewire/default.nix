{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.pipewire;
in
{
  options.modules.pipewire = with types; {
    enable = mkOption {
      type = bool;
      default = true;
      description = "Pipewire audio";
    };
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
