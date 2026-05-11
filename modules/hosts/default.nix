{
  self,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;

  mkHost =
    hostname:
    let
      system = self.modules.hosts.${hostname}.system or "x86_64-linux";
      pkgsForSystem = self.zpkgsLib.importPackages.${system} or { };

    in
    nixosSystem {
      modules = [
        self.modules.hosts.${hostname}
        {
          nixpkgs.overlays = import ../../overlays { inherit inputs; };
        }
      ];
      specialArgs = {
        pkgsForSystem = pkgsForSystem;
        scripts = pkgsForSystem.scripts or { };
        inherit
          self
          inputs
          system
          ;
      };
    };

  hosts = builtins.attrNames self.modules.hosts;
in
{
  nC = lib.genAttrs hosts mkHost;
}
