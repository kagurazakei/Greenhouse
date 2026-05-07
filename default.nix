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
    neovim-nightly = {
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-rum = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
  };
  outputs = resolvedInputs: {
    resolved = resolvedInputs;
  };
  flakeResult = with-inputs-lib sources inputSpec outputs;
  resolvedInputs = flakeResult.resolved;

  myPackages = import ./pkgs {
    pkgs = nixpkgs;
    lib = nixpkgs.lib;
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
            zpkgs = myPackages;
            inherit self;
            resolvedInputs = resolvedInputs; # Now available in modules
          };
        }
      ];
  };

  self =
    (nixpkgs.lib.evalModules {
      modules = [ modules ];
      specialArgs = {
        inherit
          self
          utils
          inputs
          username
          with-inputs-lib
          resolvedInputs
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
