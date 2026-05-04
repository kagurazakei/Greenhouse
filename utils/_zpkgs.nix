let
  sources = import ../npins;
  pkgs = import sources.nixpkgs { };
  inherit (pkgs.lib)
    getAttrs
    mapAttrs
    filesystem
    callPackageWith
    ;
in
{
  self,
  nixpkgs,
  systems,
}:
{
  mkPkgx = system: self.packages.${system};
  mkPkgx' = pkgs: self.lib.mkPkgx pkgs.stdenv.hostPlatform.system;
  pkgsFor = getAttrs systems nixpkgs.legacyPackages;
  eachSystem =
    fn:
    mapAttrs (
      system: pkgs:
      let
        zpkgs = self.lib.mkPkgx system;
      in
      fn { inherit system pkgs zpkgs; }
    ) (getAttrs systems nixpkgs.legacyPackages);
  importPackages = self.lib.eachSystem (
    { zpkgs, system, ... }:
    let
      pkgs' = import sources.unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    filesystem.packagesFromDirectoryRecursive {
      inherit (pkgs') newScope;
      callPackage = callPackageWith (pkgs' // zpkgs);
      directory = self.paths.pkgs;
    }
  );
  getPkg =
    {
      pkgName,
      system ? builtins.currentSystem,
    }:
    (self.lib.importPackages.${system}.${pkgName} or null);

  listPkgs = system: builtins.attrNames (self.lib.importPackages.${system} or { });
}
