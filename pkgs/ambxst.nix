{ pkgs }:
pkgs.symlinkJoin {
  name = "ambxst";
  paths = [ (builtins.storePath /persist/nix-gcroots/ambxst-custom) ];
}
