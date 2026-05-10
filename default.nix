let
  sources = import ./npins;
  nixpkgs = import sources.nixpkgs { };
  utils = import ./utils;
  inputs = import ./inputs.nix;
  username = "antonio";
  with-inputs-lib = import sources.with-inputs;
  inputSpec = {
    nixpkgs = inputs.nixpkgs;
    hjem = inputs.hjem;
    flake-utils = inputs.flake-utils;
    quickshell = inputs.quickshell;
    hyprland = inputs.hyprland;
    niri = inputs.niri;
    crane = inputs.crane;
    sysc-greet = {
      inputs.utils.follows = "flake-utils";
      inputs.hyprland.follows = "hyprland";
      inputs.niri.follows = "niri";
    };
    neovim-nightly = {
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-rum = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
    ambxst.quickshell.follows = "quickshell";
    tuigreet = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
    };
  };
  outputs = with-inputs: {
    resolved = with-inputs;
  };
  flakeResult = with-inputs-lib sources inputSpec outputs;
  with-inputs = flakeResult.resolved;
  zpkgs =
    let
      lib = nixpkgs.lib;
      filesystem = lib.filesystem;
      callPackageWith = lib.callPackageWith;
      system = nixpkgs.stdenv.hostPlatform.system;
      pkgs = import sources.nixpkgs {
        inherit system sources;
        config.allowUnfree = true;
      };
      callPackage = callPackageWith pkgs;
    in
    {
      customDeri = filesystem.packagesFromDirectoryRecursive {
        inherit (pkgs) newScope;
        inherit callPackage;
        directory = self.paths.pkgs;
      };
    };
  modules = {
    imports =
      utils.recursiveImport {
        dirs = [
          ./modules
          ./options
        ];
        excludePrefixedWith = [
          "_"
          "+"
        ];
      }
      ++ [
        {
          _module.args = {
            zpkgs = zpkgs.customDeri;
            inherit self;
          };
        }
      ];
  };
  self =
    (nixpkgs.lib.evalModules {
      modules = [ modules ];

      specialArgs = {
        inherit
          utils
          inputs
          username
          with-inputs-lib
          with-inputs
          ;
        pkgs = nixpkgs;
      };
    }).config
    // {
      paths = {
        dots = ./dots;
        templates = ./templates;
        pkgs = ./pkgs;
        secrets = ./secrets;
      };
    };
in
self
