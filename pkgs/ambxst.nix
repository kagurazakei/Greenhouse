{ pkgs }:
pkgs.symlinkJoin {
  name = "ambxst-working";
  paths = [ (builtins.storePath /persist/nix-gcroots/ambxst-working) ];
}
