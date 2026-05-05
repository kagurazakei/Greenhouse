let
  sources = import ./npins;
  nixpkgs = import sources.nixpkgs { };
  utils = import ./utils;
  inputs = import ./inputs.nix;
  username = "antonio";
  with-inputs = import sources.with-inputs sources {
    hjem-rum = inputs.hjem;
  };
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
