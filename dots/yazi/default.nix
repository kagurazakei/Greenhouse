{
  pkgs,
  yazi,
  ...
}:
yazi.override {
  plugins = {
    inherit (pkgs.yaziPlugins)
      git
      ouch
      relative-motions
      smart-enter
      yatline-githead
      yatline
      compress
      smart-filter
      wl-clipboard
      starship
      lazygit
      full-border
      eza-preview
      ;
  };
  initLua = ./init.lua;
  flavors = {
    oxocarbon = ./flavors/oxocarbon.yazi;
  };

  settings.package = builtins.readFile ./theme.toml |> fromTOML;
  settings.keymap = builtins.readFile ./keymap.toml |> fromTOML;
  settings.theme = builtins.readFile ./theme.toml |> fromTOML;
  settings.yazi = builtins.readFile ./yazi.toml |> fromTOML;
}
