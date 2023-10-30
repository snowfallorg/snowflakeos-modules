{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.packagemanagers;
in
{
  options.modules.packagemanagers = with types; {
    appimage.enable =
      mkEnableOption "Enable AppImage";
  };

  config = mkIf cfg.appimage.enable {
    environment.systemPackages = [ pkgs.appimage-run ];
  };
}
