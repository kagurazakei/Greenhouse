let
  sources = import ./npins;
  nixpkgs = import sources.nixpkgs { };
  utils = import ./utils;
  inputs = import ./inputs.nix;
  username = "antonio";
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
          ;
        pkgs = nixpkgs;
      };
    }).config
    // {
      paths = {
        dots = ./modules/hosts/kagura/hjem/antonio/_config;
        templates = ./templates;
        pkgs = ./pkgs;
        secrets = ./secrets;
      };
    };
in
self
