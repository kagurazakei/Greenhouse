{ pkgs, lib, ... }:
let
  # Create a custom callPackage that includes common helpers
  customCallPackage =
    path: extraArgs:
    pkgs.callPackage path (
      {
        inherit (pkgs) writeShellScriptBin writeShellScript;
        writeAwk = pkgs.writeShellScriptBin "awk-script" "...";
      }
      // extraArgs
    );
in
lib.fix (
  self:
  let
    inherit (pkgs) callPackage;
  in
  {
    viu = callPackage ./viu.nix { };
    qt6ct = callPackage ./qt6ct.nix { };
    gtk-themes = callPackage ./gtk-themes.nix { };
    equibop = callPackage ./equibop/package.nix { };
    scripts = {
      npins-show = customCallPackage ./scripts/npins-show.nix { };
      lutui = customCallPackage ./scripts/lutui.nix { };
      nixy = customCallPackage ./scripts/nixy.nix { };
      npins-helper = customCallPackage ./scripts/npins-helper.nix { };
      npins-ui = customCallPackage ./scripts/npins-ui.nix;
      touchpad-toggle = customCallPackage ./scripts/touchpad-toggle.nix { };
    };
  }
)
