{ pkgs, lib, ... }:
lib.fix (
  self:
  let
    inherit (pkgs) callPackage;
  in
  {
    viu = callPackage ./viu.nix { };
    qt6ct = callPackage ./qt6ct.nix { };
    gtk-themes = callPackage ./gtk-themes.nix { };
    scripts = {
      npins-show = callPackage ./scripts/npins-show.nix { };
    };
  }
)
