{
  self,
  inputs,
  utils,
  username,
  ...
}:
{

  modules.programs.dots_hyprland = utils.mkDotsModule username {
    "kitty/kitty.conf" = "/kitty/kagura.conf";
    "hypr/hyprland.conf" = "/hyprland/hyprland.conf";
    "hypr/keybinds.conf" = "/hyprland/keybinds.conf";
    "hypr/windowRules.conf" = "/hyprland/windowRules.conf";
    "hypr/animations" = "/hyprland/animations";
    "hypr/hyprcolors.conf" = "/hyprland/hyprcolors.conf";
    "hypr/hypridle.conf" = "/hyprland/hypridle.conf";
  };
  modules.wm.hyprland =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [ self.modules.wm._ ];

      options = {
        wm.hyprland.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        wm.hyprland.buildFromSrc = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };

      config = lib.mkIf (config.wm.hyprland.enable) {
        programs.hyprland = {
          enable = true;
          withUWSM = true;
          xwayland.enable = true;
        }
        // lib.optionalAttrs (config.wm.hyprland.buildFromSrc) {
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };

        xdg.portal = {
          config.hyprland = {
            default = [
              "hyprland"
              "kde"
            ];
          };
        };

        #polkit
        environment.systemPackages = [
          pkgs.kdePackages.qtwayland
          pkgs.libsForQt5.qt5.qtwayland
          pkgs.hyprpolkitagent
          pkgs.hyprshutdown
          pkgs.app2unit
          pkgs.kitty
        ];
      };
    };
}
