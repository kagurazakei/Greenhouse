{
  pkgs,
  lib,
  writers,
  fzf,
  bash,
  coreutils,
  gnused,
  npins,
  wl-clipboard,
  xdg-utils,
  util-linux,
  writeShellScriptBin,
}:

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
      npins-show = callPackage ./scripts/npins-show.nix {
        inherit npins util-linux coreutils;
      };
      lutui = callPackage ./scripts/lutui.nix {
        inherit
          writers
          pkgs
          ;
      };
      nixy = callPackage ./scripts/nixy.nix {
        inherit
          writeShellScriptBin
          fzf
          ;
      };
      npins-helper = callPackage ./scripts/npins-helper.nix {
        inherit
          writers
          bash
          npins
          coreutils
          gnused
          ;
      };
      npins-ui = callPackage ./scripts/npins-ui.nix {
        inherit
          writers
          fzf
          coreutils
          gnused
          npins
          wl-clipboard
          xdg-utils
          ;
      };
      touchpad-toggle = callPackage ./scripts/touchpad-toggle.nix { inherit pkgs writers; };
    };
  }
)
