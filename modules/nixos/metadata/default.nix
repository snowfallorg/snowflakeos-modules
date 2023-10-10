{ config, lib, ... }:

with lib;
{
  config = {
    environment.etc = builtins.mapAttrs
      (name: path: {
        source = ../${path}/module.yml;
      })
      (lib.filterAttrs (n: v: lib.hasAttr "module.yml" (builtins.readDir ../${v})) (lib.mapAttrs' (name: value: nameValuePair ("snowflakeos-modules/${name}/module.yml") name) (builtins.readDir ./..)));
  };
}
