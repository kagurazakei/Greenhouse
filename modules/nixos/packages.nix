{ inputs, zpkgs, ... }:
{
  modules.nixos.packages =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      npins =
        if (config.nixos.packages.npins.buildFromSrc) then
          (pkgs.callPackage (inputs.npins + "/npins.nix") { })
        else
          pkgs.npins;
      gtk-themes = pkgs.callPackage ../../pkgs/gtk-themes.nix { };
      qt6ct = pkgs.callPackage ../../pkgs/qt6ct.nix { };
      equibop = pkgs.callPackage ../../pkgs/equibop/package.nix { };
    in
    {
      options = {
        nixos.packages.npins.buildFromSrc = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
      config = {
        programs.direnv = {
          enable = true;
          loadInNixShell = true;
          nix-direnv.enable = true;
          enableFishIntegration = true;
        };

        environment.systemPackages = [
          npins
          gtk-themes
          qt6ct
          equibop
        ]
        ++ builtins.attrValues {
          inherit (pkgs)
            git
            gh
            just
            gnupg
            yazi
            neovim
            nh
            wl-clipboard
            cliphist
            libnotify
            librewolf
            cachix
            gtk-engine-murrine
            rose-pine-icon-theme
            rose-pine-gtk-theme
            ;
        };
      };
    };
}
