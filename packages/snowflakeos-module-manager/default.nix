{ inputs, system }:
inputs.snowflakeos-module-manager.packages.${pkgs.stdenv.hostPlatform.system}.snowflakeos-module-manager
