{
  pkgs,
  ...
}:
{
  networking.hostName = "snow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console.useXkbConfig = true;

  users.users."test" = {
    isNormalUser = true;
    description = "test user";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    htop
  ];

  system.stateVersion = "26.05";
}
