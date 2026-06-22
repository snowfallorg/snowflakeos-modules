{
  inputs,
  system,
  pkgs,
}:
inputs.snow.packages.${pkgs.stdenv.hostPlatform.system}.snow
