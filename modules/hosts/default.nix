{
  self,
  inputs,
  lib,
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
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [
              (_final: prev: {
                system = prev.stdenv.hostPlatform.system;
                master = import inputs.master {
                  inherit (prev.stdenv.hostPlatform) system;
                  config.allowUnfree = true;
                };
                swww = pkgs.awww;
              })
            ];
          }
        )
      ];
      specialArgs = {
        pkgsForSystem = pkgsForSystem;
        scripts = pkgsForSystem.scripts or { };
        inherit
          self
          inputs
          ;
      };
    };

  hosts = builtins.attrNames self.modules.hosts;
in
{
  nC = lib.genAttrs hosts mkHost;
}
