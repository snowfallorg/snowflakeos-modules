# source: https://discourse.nixos.org/t/nixostest-with-flake-configurations/11542/5
{
  inputs,
  pkgs,
  ...
}:
pkgs.testers.runNixOSTest {
  name = "Efiboot config test";

  nodes.machine =
    { ... }:
    {
      imports = with inputs.self; [
        nixosModules.efiboot
        nixosModules.gnome
        nixosModules.kernel
        nixosModules.metadata
        nixosModules.networking
        nixosModules.packagemanagers
        nixosModules.pipewire
        nixosModules.printing
        nixosModules.snowflakeos
        ./configuration.nix
      ];
    };

  node = {
    # since we are using an overlay, we must make pkgs writable
    pkgsReadOnly = false;

    specialArgs = { inherit inputs; };
  };

  # disable only when working on testScript
  skipTypeCheck = true;

  testScript = ''
    machine.start()
    machine.wait_for_unit("multi-user.target")
    machine.succeed("uname -a")
    machine.succeed("echo Modules succesfully tested")
  '';
}
