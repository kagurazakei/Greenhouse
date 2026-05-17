{
  inputs,
  self,
  lib,
  ...
}:
{
  modules.programs.qylock =
    { config, ... }:
    {
      imports = [ inputs.qylock-nix.nixosModules.default ];
      options = {
        dm.qylock.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
      config = lib.mkIf (config.dm.qylock.enable) {
        programs.qylock = {
          enable = true;
          theme = "pixel-emerald";
          sddmTheme = "pixel-emerald";
          sddmThemeFonts = [ (self.paths.dots + /PixelifySans-Bold.ttf) ];
        };
        services.displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };
}
