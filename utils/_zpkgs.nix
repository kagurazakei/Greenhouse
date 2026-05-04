let
  sources = import ../npins;
  nixpkgs = import sources.nixpkgs { };
  inherit (nixpkgs.lib)
    getAttrs
    mapAttrs
    filesystem
    callPackageWith
    ;
  pathExists = path: builtins.pathExists path;
  currentSystem = builtins.currentSystem or "x86_64-linux";
in
{
  self,
  systems ? [
    "x86_64-linux"
    "aarch64-linux"
  ],
}:

let
  mkPkgx = system: self.packages.${system} or { };
  mkPkgx' = pkgs: mkPkgx pkgs.stdenv.hostPlatform.system;
  pkgsFor = getAttrs systems nixpkgs.legacyPackages;

  eachSystem =
    fn:
    mapAttrs (
      system: pkgs:
      let
        zpkgs = mkPkgx system;
      in
      fn { inherit system pkgs zpkgs; }
    ) pkgsFor;

  importPackages =
    let
      importForSystem =
        system:
        let
          pkgs' = import sources.unstable {
            inherit system;
            config.allowUnfree = true;
          };
          zpkgs = mkPkgx system;
        in
        if pathExists self.paths.pkgs then
          filesystem.packagesFromDirectoryRecursive {
            inherit (pkgs') newScope;
            callPackage = callPackageWith (pkgs' // zpkgs);
            directory = self.paths.pkgs;
          }
        else
          { };
    in
    eachSystem ({ system, ... }: importForSystem system);
  overlay =
    final: prev:
    let
      currentSystem = final.stdenv.hostPlatform.system;
      systemPackages = importPackages.${currentSystem} or { };
    in
    {
      zpkgs = systemPackages // {
        scripts = systemPackages.scripts or { };
      };
    };

in
{
  inherit
    mkPkgx
    mkPkgx'
    pkgsFor
    eachSystem
    importPackages
    overlay
    ;
  defaultOverlay = overlay;
}
