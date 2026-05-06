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
    in
    {
      options = {
        nixos.packages.npins.buildFromSrc = lib.mkOption {
          type = lib.types.bool;
          default = true;
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
        ]
        ++ builtins.attrValues {
          inherit (zpkgs)
            qt6ct
            gtk-themes
            viu
            ;
          inherit (pkgs.master)
            nh
            cachix
            equibop
            ;
          inherit (pkgs)
            ffmpeg
            nix-init
            neovide
            git
            gh
            just
            gnupg
            lolcat
            yazi
            neovim
            wl-clipboard
            cliphist
            libnotify
            librewolf
            gtk-engine-murrine
            rose-pine-icon-theme
            rose-pine-gtk-theme
            vscodium
            ;
        };
      };
    };
}
