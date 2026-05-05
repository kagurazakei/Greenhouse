let
  sources = import ../npins;
  nixpkgs = import sources.nixpkgs { };
  utils = import ./default.nix;
  inherit (nixpkgs.lib)
    getAttrs
    mapAttrs
    callPackageWith
    ;
  inherit (utils) recursiveImport;

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
      fn {
        inherit system pkgs;
        zpkgs = mkPkgx system;
      }
    ) pkgsFor;

  # Simple recursive import that preserves structure
  importPackagesFromDir =
    dir:
    let
      # Get all .nix files recursively
      nixFiles = recursiveImport {
        dirs = [ dir ];
        excludePrefixedWith = [ "_" ];
      };

      # Filter self
      myFiles = builtins.filter (f: builtins.baseNameOf f != "default.nix") nixFiles;

      # Group files by their parent directory
      groupByDir = builtins.groupBy (
        f:
        let
          parent = builtins.baseNameOf (builtins.dirOf f);
        in
        if parent == "pkgs" || parent == "." then "root" else parent
      ) myFiles;

      # Import function for a system
      importSystem =
        system:
        let
          pkgs' = import sources.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        builtins.mapAttrs (
          group: files:
          builtins.listToAttrs (
            builtins.map (f: {
              name = builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf f);
              value = pkgs'.callPackage f { };
            }) files
          )
        ) groupByDir;

    in
    importSystem;

  importPackages =
    let
      importForSystem =
        system:
        if pathExists self.paths.pkgs then
          (importPackagesFromDir self.paths.pkgs).${system} or { }
        else
          { };
    in
    eachSystem ({ system, ... }: importForSystem system);

  overlay =
    final: prev:
    let
      currentSystem = final.stdenv.hostPlatform.system;
      systemPackages = importPackages.${currentSystem} or { };
      rootPkgs = systemPackages.root or { };
      scripts = systemPackages.scripts or { };
    in
    {
      zpkgs = rootPkgs // {
        inherit scripts;
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
