{
  description = "SnowflakeOS Modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-software-center = {
      url = "github:vlinkz/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-conf-editor = {
      url = "github:vlinkz/nixos-conf-editor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snow = {
      url = "github:snowflakelinux/snow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowflakeos-module-manager = {
      url = "github:snowflakelinux/snowflakeos-module-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
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
