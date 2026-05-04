{ utils, username, ... }:
{

  modules.programs.dots_yazi = utils.mkDotsModule username {
    "yazi/init.lua" = "/yazi/init.lua";
    "yazi/yazi.toml" = "/yazi/yazi.toml";
    "yazi/keymap.toml" = "/yazi/keymap.toml";
    "yazi/package.toml" = "/yazi/package.toml";
    "yazi/theme.toml" = "/yazi/theme.toml";
    "yazi/flavors/oxocarbon.yazi/flavor.toml" = "/yazi/flavors/oxocarbon.yazi/flavor.toml";
    "yazi/flavors/catppuccin-macchiato.yazi/flavor.toml" =
      "/yazi/flavors/catppuccin-macchiato.yazi/flavor.toml";
  };

  modules.programs.dots_hyprland = utils.mkDotsModule username {
    "hypr/hyprland.conf" = "/hyprland/hyprland.conf";
    "hypr/keybinds.conf" = "/hyprland/keybinds.conf";
    "hypr/windowRules.conf" = "/hyprland/windowRules.conf";
  };
  modules.programs.yazi =
    {
      pkgs,
      ...
    }:
    {
      hj = {
        packages = with pkgs; [
          yazi
        ];
      };
    };
}
