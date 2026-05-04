let
  sources = import ./+npins;
  nixpkgs = import sources.nixpkgs { };
  utils = import ./utils;
  inputs = import ./inputs.nix;
  username = "antonio";

  modules = {
    imports = utils.recursiveImport {
      dirs = [
        ./modules
        ./options
      ];
      excludePrefixedWith = [
        "_"
        "+"
      ];
    };
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
