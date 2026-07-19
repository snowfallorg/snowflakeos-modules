{ inputs, system, pkgs }:
inputs.snowflakeos-module-manager.packages.${pkgs.stdenv.hostPlatform.system}.snowflakeos-module-manager
