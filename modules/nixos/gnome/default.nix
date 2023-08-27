{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.modules.gnome;
in
{
  options.modules.gnome = with types; {
    enable =
      lib.mkEnableOption "GNOME desktop environment";
    gsconnect =
      lib.mkEnableOption "Enable KDE Connect integration";
  };

  config = mkIf cfg.enable {

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.enable = true;

    # Fix GNOME autologin
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    programs.kdeconnect = mkIf cfg.gsconnect {
      package = pkgs.gnomeExtensions.gsconnect;
      enable = true;
    };

    services.xserver.displayManager.gdm.wayland = true;
    xdg.portal.enable = true;
    services.gvfs.enable = true;
    programs.dconf.enable = true;
  };
}
