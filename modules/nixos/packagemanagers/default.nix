{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.packagemanagers;
in
{
  options.modules.packagemanagers = with types; {
    flatpak =
      mkEnableOption "Enable Flatpak";
    appimage =
      mkEnableOption "Enable AppImage";
  };

  config = mkMerge [
    (mkIf cfg.flatpak {
      services.flatpak.enable = true;
    })
    (mkIf cfg.appimage {
      environment.systemPackages = [ pkgs.appimage-run ];
    })
  ];
}
