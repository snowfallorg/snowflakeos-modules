{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.gnome;
in
{
  options.modules.gnome = with types; {
    gsconnect.enable =
      mkEnableOption "Enable KDE Connect integration";
    removeUtils.enable =
      mkEnableOption "Remove non-essential GNOME utilities";
  };

  config = {

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.wayland = true;

    # Fix GNOME autologin
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    programs.gnupg.agent.pinentryFlavor = mkDefault "gnome3";

    programs.kdeconnect = mkIf cfg.gsconnect.enable {
      package = pkgs.gnomeExtensions.gsconnect;
      enable = true;
    };

    environment.gnome.excludePackages = mkIf cfg.removeUtils.enable (with pkgs.gnome; [
      baobab
      cheese
      eog
      epiphany
      file-roller
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-weather
      pkgs.gnome-connections
      pkgs.gnome-photos
      pkgs.gnome-text-editor
      simple-scan
      totem
    ]);
  };
}
