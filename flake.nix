{
  description = "SnowflakeOS Modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    snow.url = "github:snowflakelinux/snow";
    snowflakeos-module-manager.url = "github:snowflakelinux/snowflakeos-module-manager"
    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      channels-config.allowUnfree = true;
      src = ./.;
    };
}
