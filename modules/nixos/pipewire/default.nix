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
    security.rtkit.enable = true;
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
