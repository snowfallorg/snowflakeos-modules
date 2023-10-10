{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.packagemanagers;
in
{
  options.modules.packagemanagers = with types; {
    appimage =
      mkEnableOption "Enable AppImage";
  };

  config = mkIf cfg.appimage {
    environment.systemPackages = [ pkgs.appimage-run ];
  };
}
